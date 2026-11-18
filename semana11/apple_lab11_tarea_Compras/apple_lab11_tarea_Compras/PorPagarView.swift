import SwiftUI
import SwiftData

// B8: Cuentas por pagar (compras aprobadas a crédito)
struct PorPagarView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Compra> { $0.estado == "Aprobada" && $0.alCredito == true },
           sort: \Compra.vence)
    private var creditos: [Compra]

    @State private var filtro = "Pendientes"
    @State private var busqueda = ""
    private let filtros = ["Pendientes", "Vencidas", "Pagadas"]

    // ① Pendientes / Vencidas / Pagadas
    private var lista: [Compra] {
        creditos
            .filter { compra in
                switch filtro {
                case "Vencidas": return !compra.pagada && compra.estaVencida
                case "Pagadas": return compra.pagada
                default: return !compra.pagada && !compra.estaVencida
                }
            }
            .filter {
                busqueda.isEmpty || ($0.proveedor?.nombre.localizedCaseInsensitiveContains(busqueda) ?? false)
            }
    }

    // ⑤ Total por pagar (pendientes + vencidas)
    private var totalPorPagar: Double {
        creditos.filter { !$0.pagada }.reduce(0) { $0 + $1.total }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Label("Total por pagar", systemImage: "creditcard")
                        Spacer()
                        Text(totalPorPagar.soles).bold().foregroundStyle(.orange)
                    }
                    Picker("Filtro", selection: $filtro) {
                        ForEach(filtros, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                }

                Section(filtro) {
                    if lista.isEmpty {
                        Text("Sin compras en esta lista").foregroundStyle(.secondary)
                    }
                    // ② compra a crédito  ③ etiqueta VENCIDA  ④ deslizar Pagar
                    ForEach(lista) { compra in
                        FilaCompra(compra: compra, mostrarComprador: true)
                            .swipeActions(edge: .trailing) {
                                if !compra.pagada {
                                    Button {
                                        pagar(compra)
                                    } label: {
                                        Label("Pagar", systemImage: "checkmark.circle")
                                    }
                                    .tint(.green)
                                }
                            }
                    }
                }
            }
            .searchable(text: $busqueda, prompt: "Buscar por proveedor")
            .navigationTitle("Por pagar")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { AvatarMenu() }
            }
        }
    }

    // R5: marca la compra como pagada
    private func pagar(_ compra: Compra) {
        compra.pagada = true
        try? modelContext.save()
    }
}
