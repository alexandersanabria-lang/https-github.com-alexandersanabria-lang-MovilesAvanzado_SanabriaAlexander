import SwiftUI
import SwiftData

// B6: Mis compras (el comprador solo ve las suyas)
struct MisComprasView: View {
    @Environment(Sesion.self) private var sesion
    @Query(sort: \Compra.fecha, order: .reverse) private var compras: [Compra]

    @State private var filtro = "Todas"
    @State private var busqueda = ""
    private let filtros = ["Todas", "Pendientes", "Rechazadas"]

    private var misCompras: [Compra] {
        compras
            .filter { $0.comprador == sesion.usuario }                // ④ solo las suyas
            .filter { compra in                                        // ① segmented
                switch filtro {
                case "Pendientes": return compra.estado == "Pendiente"
                case "Rechazadas": return compra.estado == "Rechazada"
                default: return true
                }
            }
            .filter {                                                  // búsqueda por proveedor
                busqueda.isEmpty || ($0.proveedor?.nombre.localizedCaseInsensitiveContains(busqueda) ?? false)
            }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("Filtro", selection: $filtro) {
                        ForEach(filtros, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                }

                Section {
                    if misCompras.isEmpty {
                        Text("No tienes compras en esta lista")
                            .foregroundStyle(.secondary)
                    }
                    // ② pendientes  ③ rechazadas con su motivo (sin opción de pagar)
                    ForEach(misCompras) { compra in
                        FilaCompra(compra: compra)
                    }
                }
            }
            .searchable(text: $busqueda, prompt: "Buscar por proveedor")
            .navigationTitle("Mis compras")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { AvatarMenu() }
            }
        }
    }
}
