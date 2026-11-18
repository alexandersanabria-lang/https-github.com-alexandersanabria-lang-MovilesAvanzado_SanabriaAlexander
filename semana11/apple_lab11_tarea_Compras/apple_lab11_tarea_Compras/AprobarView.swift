import SwiftUI
import SwiftData

// B7: Aprobar o rechazar compras desde S/ 5,000 (supervisor)
struct AprobarView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Compra> { $0.estado == "Pendiente" }, sort: \Compra.fecha)
    private var pendientes: [Compra]

    @State private var compraARechazar: Compra?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    if pendientes.isEmpty {
                        ContentUnavailableView("Nada por aprobar",
                                               systemImage: "checkmark.seal",
                                               description: Text("Las compras desde S/ 5,000 aparecerán aquí."))
                            .padding(.top, 60)
                    }
                    ForEach(pendientes) { compra in
                        TarjetaAprobacion(
                            compra: compra,
                            aprobar: { aprobar(compra) },
                            rechazar: { compraARechazar = compra }
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Aprobar")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { AvatarMenu() }   // ① avatar
            }
            .sheet(item: $compraARechazar) { RechazoView(compra: $0) }
        }
    }

    // Aprobar: se aplican los efectos (stock y costo promedio)
    private func aprobar(_ compra: Compra) {
        compra.estado = "Aprobada"
        ServicioCompras.aplicarEfectos(de: compra)
        try? modelContext.save()
    }
}

// ② Tarjeta de la compra pendiente  ③ vista previa del efecto  ④ Rechazar o Aprobar
private struct TarjetaAprobacion: View {
    let compra: Compra
    let aprobar: () -> Void
    let rechazar: () -> Void

    private var stockAntes: Int { compra.producto?.stock ?? 0 }
    private var stockDespues: Int { stockAntes + compra.cantidad }
    private var costoAntes: Double { compra.producto?.costoPromedio ?? 0 }
    private var costoDespues: Double {
        ServicioCompras.nuevoCostoPromedio(stock: stockAntes, costoPromedio: costoAntes,
                                           cantidad: compra.cantidad, costoUnitario: compra.costoUnitario)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(compra.producto?.nombre ?? "Producto").font(.headline)
                    Text(compra.proveedor?.nombre ?? "Proveedor").foregroundStyle(.secondary)
                }
                Spacer()
                Text(compra.total.soles).font(.title3.bold())
            }

            Label("Solicitó: \(compra.comprador?.nombre ?? "—")", systemImage: "person.fill")
                .font(.subheadline)

            Text("\(compra.cantidad) × \(compra.costoUnitario.soles) · \(compra.alCredito ? "Crédito 30 días" : "Contado") · \(compra.fecha.corta)")
                .font(.caption)
                .foregroundStyle(.secondary)

            Divider()

            Text("Efecto al aprobar")
                .font(.caption.bold())
                .foregroundStyle(.secondary)
            HStack {
                efecto(titulo: "Stock", antes: "\(stockAntes)", despues: "\(stockDespues)")
                Spacer()
                efecto(titulo: "Costo promedio", antes: costoAntes.soles, despues: costoDespues.soles)
            }

            HStack {
                Button(role: .destructive, action: rechazar) {
                    Label("Rechazar", systemImage: "xmark").frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)

                Button(action: aprobar) {
                    Label("Aprobar", systemImage: "checkmark").frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
        }
        .padding()
        .background(.gray.opacity(0.08), in: RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.orange.opacity(0.4)))
    }

    private func efecto(titulo: String, antes: String, despues: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(titulo).font(.caption).foregroundStyle(.secondary)
            HStack(spacing: 4) {
                Text(antes)
                Image(systemName: "arrow.right").font(.caption)
                Text(despues).bold()
            }
            .font(.subheadline)
        }
    }
}

// Hoja para rechazar con motivo obligatorio
struct RechazoView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let compra: Compra
    @State private var motivo = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Compra") {
                    LabeledContent("Producto", value: compra.producto?.nombre ?? "—")
                    LabeledContent("Solicitó", value: compra.comprador?.nombre ?? "—")
                    LabeledContent("Total", value: compra.total.soles)
                }
                Section("Motivo del rechazo (obligatorio)") {
                    TextField("Escribe el motivo", text: $motivo, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Rechazar compra")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Rechazar", role: .destructive) { rechazar() }
                        .disabled(motivo.limpio.isEmpty)        // sin motivo no se puede
                }
            }
        }
        .presentationDetents([.medium, .large])
    }

    // Rechazar: no cambia stock ni costo promedio
    private func rechazar() {
        compra.estado = "Rechazada"
        compra.motivoRechazo = motivo.limpio
        try? modelContext.save()
        dismiss()
    }
}
