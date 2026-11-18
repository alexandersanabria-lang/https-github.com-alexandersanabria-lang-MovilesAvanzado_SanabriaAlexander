import SwiftUI
import SwiftData
import Charts

// B9: Resumen del supervisor
struct ResumenView: View {
    @Environment(Sesion.self) private var sesion
    @Query private var productos: [Producto]
    @Query private var compras: [Compra]
    @Query(sort: \Proveedor.nombre) private var proveedores: [Proveedor]

    private var aprobadas: [Compra] { compras.filter { $0.estado == "Aprobada" } }
    private var pendientes: [Compra] { compras.filter { $0.estado == "Pendiente" } }

    private var valorInventario: Double { productos.reduce(0) { $0 + $1.valorInventario } }      // ②
    private var creditoFiscal: Double { aprobadas.reduce(0) { $0 + $1.igv } }                    // ③
    private var porPagar: Double {
        aprobadas.filter { $0.alCredito && !$0.pagada }.reduce(0) { $0 + $1.total }
    }
    private var importePorAprobar: Double { pendientes.reduce(0) { $0 + $1.total } }             // ④

    // ⑤ Total comprado por proveedor
    private var datosProveedor: [TotalProveedor] {
        proveedores
            .map { TotalProveedor(nombre: $0.nombre, total: $0.totalComprado) }
            .filter { $0.total > 0 }
            .sorted { $0.total > $1.total }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Hola, \(sesion.usuario?.nombre ?? "")")
                        .font(.title2.bold())

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        TarjetaResumen(titulo: "Valor del inventario", valor: valorInventario.soles,
                                       icono: "shippingbox.fill", color: .indigo)
                        TarjetaResumen(titulo: "Crédito fiscal (IGV)", valor: creditoFiscal.soles,
                                       icono: "percent", color: .teal)
                        TarjetaResumen(titulo: "Por pagar", valor: porPagar.soles,
                                       icono: "creditcard.fill", color: .orange)
                        TarjetaResumen(titulo: "Por aprobar (\(pendientes.count))", valor: importePorAprobar.soles,
                                       icono: "hourglass", color: .pink)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Total comprado por proveedor").font(.headline)
                        if datosProveedor.isEmpty {
                            Text("Aún no hay compras aprobadas.").foregroundStyle(.secondary)
                        } else {
                            Chart(datosProveedor) { dato in
                                BarMark(
                                    x: .value("Total", dato.total),
                                    y: .value("Proveedor", dato.nombre)
                                )
                                .foregroundStyle(Color.indigo.gradient)
                                .annotation(position: .trailing) {
                                    Text(dato.total.soles).font(.caption2)
                                }
                            }
                            .chartXAxis(.hidden)
                            .frame(height: CGFloat(datosProveedor.count) * 50 + 20)
                        }
                    }
                    .padding()
                    .background(.gray.opacity(0.08), in: RoundedRectangle(cornerRadius: 16))
                }
                .padding()
            }
            .navigationTitle("Resumen")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { AvatarMenu() }    // ① avatar
            }
        }
    }
}

// Dato para el gráfico de barras
struct TotalProveedor: Identifiable {
    let nombre: String
    let total: Double
    var id: String { nombre }
}

// Tarjeta de indicador
private struct TarjetaResumen: View {
    let titulo: String
    let valor: String
    let icono: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icono)
                .foregroundStyle(color)
                .font(.title3)
            Text(valor)
                .font(.headline)
                .minimumScaleFactor(0.7)
                .lineLimit(1)
            Text(titulo)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(color.opacity(0.1), in: RoundedRectangle(cornerRadius: 14))
    }
}
