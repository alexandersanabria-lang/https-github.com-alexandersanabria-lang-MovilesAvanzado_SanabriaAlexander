import SwiftUI
import SwiftData

// B5: Registrar una compra (comprador)
struct NuevaCompraView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion
    @Query(sort: \Proveedor.nombre) private var proveedores: [Proveedor]
    @Query(sort: \Producto.nombre) private var productos: [Producto]

    @State private var proveedor: Proveedor?
    @State private var producto: Producto?
    @State private var cantidadTexto = "1"
    @State private var costoTexto = ""
    @State private var alCredito = false
    @State private var fecha = Date.now
    @State private var mensaje: String?

    // Cálculos en vivo (R1)
    private var cantidad: Int { Int(cantidadTexto) ?? 0 }
    private var costoUnitario: Double { Double(costoTexto.replacingOccurrences(of: ",", with: ".")) ?? 0 }
    private var subtotal: Double { Double(cantidad) * costoUnitario }
    private var igv: Double { subtotal * ServicioCompras.tasaIGV }
    private var total: Double { subtotal + igv }
    private var requiereAprobacion: Bool { total >= ServicioCompras.limiteAprobacion }   // R2
    private var vence: Date { Calendar.current.date(byAdding: .day, value: 30, to: fecha) ?? fecha }
    private var esValida: Bool { proveedor != nil && producto != nil && cantidad > 0 && costoUnitario > 0 }

    var body: some View {
        NavigationStack {
            Form {
                // ② Proveedor  ③ Producto
                Section("Proveedor y producto") {
                    Picker("Proveedor", selection: $proveedor) {
                        Text("Elegir…").tag(Proveedor?.none)
                        ForEach(proveedores) { p in
                            Text(p.nombre).tag(Optional(p))
                        }
                    }
                    Picker("Producto", selection: $producto) {
                        Text("Elegir…").tag(Producto?.none)
                        ForEach(productos) { p in
                            Text(p.nombre).tag(Optional(p))
                        }
                    }
                    if let producto {
                        LabeledContent("Stock actual", value: "\(producto.stock) u.")
                        LabeledContent("Costo promedio", value: producto.costoPromedio.soles)
                    }
                }

                // ④ Cantidad  ⑤ Contado o Crédito 30 días
                Section("Detalle") {
                    LabeledContent("Cantidad") {
                        TextField("0", text: $cantidadTexto)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    LabeledContent("Costo unitario (S/)") {
                        TextField("0.00", text: $costoTexto)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    Picker("Pago", selection: $alCredito) {
                        Text("Contado").tag(false)
                        Text("Crédito 30 días").tag(true)
                    }
                    .pickerStyle(.segmented)
                    DatePicker("Fecha", selection: $fecha, displayedComponents: .date)
                }

                // Resumen calculado
                Section("Resumen") {
                    LabeledContent("Subtotal", value: subtotal.soles)
                    LabeledContent("IGV 18 % (crédito fiscal)", value: igv.soles)
                    LabeledContent("Total") {
                        Text(total.soles).bold()
                    }
                    if alCredito {
                        LabeledContent("Vence", value: vence.corta)
                    }
                }

                // ⑥ Aviso cuando el total llega a S/ 5,000
                if requiereAprobacion {
                    Section {
                        Label("El total llega a S/ 5,000: la compra irá a aprobación del supervisor y no cambiará el stock hasta que la apruebe.",
                              systemImage: "exclamationmark.triangle.fill")
                            .foregroundStyle(.orange)
                    }
                }

                // ⑦ Enviar a aprobación o Registrar compra
                Section {
                    Button {
                        registrar()
                    } label: {
                        Text(requiereAprobacion ? "Enviar a aprobación" : "Registrar compra")
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(!esValida)
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Nueva compra")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { AvatarMenu() }    // ① avatar de la sesión
            }
            .alert("Compra registrada",
                   isPresented: Binding(get: { mensaje != nil }, set: { if !$0 { mensaje = nil } })) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(mensaje ?? "")
            }
        }
    }

    private func registrar() {
        guard esValida, let proveedor, let producto, let usuario = sesion.usuario else { return }

        // El init calcula IGV, total, estado (R2), pagada y vence (R4)
        let compra = Compra(cantidad: cantidad, costoUnitario: costoUnitario, alCredito: alCredito, fecha: fecha)
        modelContext.insert(compra)
        // Relaciones: se asignan después de insertar
        compra.comprador = usuario
        compra.proveedor = proveedor
        compra.producto = producto

        // Menor a S/ 5,000: queda Aprobada y se aplican sus efectos al instante (R3)
        if compra.estado == "Aprobada" {
            ServicioCompras.aplicarEfectos(de: compra)
        }
        try? modelContext.save()

        if compra.estado == "Pendiente" {
            mensaje = "Total \(compra.total.soles). Quedó Pendiente de aprobación del supervisor."
        } else if compra.alCredito {
            mensaje = "Total \(compra.total.soles). Quedó Aprobada a crédito; vence el \(compra.vence.corta)."
        } else {
            mensaje = "Total \(compra.total.soles). Quedó Aprobada y pagada al contado."
        }

        // Limpia el formulario
        cantidadTexto = "1"
        costoTexto = ""
        fecha = .now
    }
}
