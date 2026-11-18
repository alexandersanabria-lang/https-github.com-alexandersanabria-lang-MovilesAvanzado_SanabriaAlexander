import SwiftUI
import SwiftData

// B3: Productos (consultar todos; crear/editar/borrar solo supervisor)
struct ProductosView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion
    @Query(sort: \Producto.nombre) private var productos: [Producto]

    @State private var busqueda = ""
    @State private var mostrarNuevo = false
    @State private var productoAEditar: Producto?
    @State private var mensajeAlerta: String?

    private var esSupervisor: Bool { sesion.usuario?.esSupervisor ?? false }

    // ② Búsqueda por nombre o categoría
    private var filtrados: [Producto] {
        if busqueda.isEmpty { return productos }
        return productos.filter {
            $0.nombre.localizedCaseInsensitiveContains(busqueda) ||
            $0.categoria.localizedCaseInsensitiveContains(busqueda)
        }
    }

    // ④ Valor del inventario (stock × costo promedio)
    private var valorInventario: Double { productos.reduce(0) { $0 + $1.valorInventario } }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Label("Valor del inventario", systemImage: "banknote")
                        Spacer()
                        Text(valorInventario.soles).bold()
                    }
                }

                Section("Productos") {
                    if filtrados.isEmpty {
                        Text(esSupervisor ? "Pulsa + para agregar un producto" : "Aún no hay productos")
                            .foregroundStyle(.secondary)
                    }
                    ForEach(filtrados) { producto in
                        Button {
                            if esSupervisor { productoAEditar = producto }
                        } label: {
                            FilaProducto(producto: producto)
                        }
                        .buttonStyle(.plain)
                        .deleteDisabled(!esSupervisor)     // ⑤ solo supervisor
                    }
                    .onDelete(perform: borrar)
                }
            }
            .searchable(text: $busqueda, prompt: "Buscar producto o categoría")
            .navigationTitle("Productos")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { AvatarMenu() }
                if esSupervisor {
                    ToolbarItem(placement: .topBarTrailing) {      // ① + solo supervisor
                        Button { mostrarNuevo = true } label: { Image(systemName: "plus") }
                    }
                }
            }
            .sheet(isPresented: $mostrarNuevo) { ProductoFormView(producto: nil) }
            .sheet(item: $productoAEditar) { ProductoFormView(producto: $0) }
            .alert("No se puede eliminar",
                   isPresented: Binding(get: { mensajeAlerta != nil }, set: { if !$0 { mensajeAlerta = nil } })) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(mensajeAlerta ?? "")
            }
        }
    }

    // ⑤ Borrado bloqueado si tiene compras (.deny)
    private func borrar(_ offsets: IndexSet) {
        for index in offsets {
            let producto = filtrados[index]
            if !producto.compras.isEmpty {
                mensajeAlerta = "\(producto.nombre) tiene compras registradas."
            } else {
                modelContext.delete(producto)
            }
        }
        try? modelContext.save()
    }
}

// ③ Fila con costo promedio y stock en color
private struct FilaProducto: View {
    let producto: Producto

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(producto.nombre).font(.headline)
                Text(producto.categoria).font(.caption).foregroundStyle(.secondary)
                Text("Costo prom. \(producto.costoPromedio.soles)").font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(producto.stock) u.")
                    .bold()
                    .foregroundStyle(producto.colorStock)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(producto.colorStock.opacity(0.15), in: Capsule())
                Text(producto.valorInventario.soles)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .contentShape(Rectangle())
    }
}

// Formulario para crear o editar un producto (solo supervisor)
struct ProductoFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let producto: Producto?

    @State private var nombre = ""
    @State private var categoria = ""
    @State private var stockTexto = ""
    @State private var costoTexto = ""

    private var stock: Int { Int(stockTexto) ?? -1 }
    private var costo: Double { Double(costoTexto.replacingOccurrences(of: ",", with: ".")) ?? -1 }
    private var esValido: Bool {
        !nombre.limpio.isEmpty && !categoria.limpio.isEmpty && (producto != nil || (stock >= 0 && costo >= 0))
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Producto") {
                    TextField("Nombre", text: $nombre)
                    TextField("Categoría", text: $categoria)
                }
                Section {
                    TextField("Stock inicial", text: $stockTexto)
                        .keyboardType(.numberPad)
                    TextField("Costo promedio (S/)", text: $costoTexto)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Inventario")
                } footer: {
                    if producto != nil {
                        Text("El stock y el costo promedio solo cambian con compras aprobadas.")
                    }
                }
                .disabled(producto != nil)
            }
            .navigationTitle(producto == nil ? "Nuevo producto" : "Editar producto")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") { guardar() }.disabled(!esValido)
                }
            }
            .onAppear {
                if let producto {
                    nombre = producto.nombre
                    categoria = producto.categoria
                    stockTexto = "\(producto.stock)"
                    costoTexto = String(format: "%.2f", producto.costoPromedio)
                }
            }
        }
    }

    private func guardar() {
        if let producto {
            producto.nombre = nombre.limpio
            producto.categoria = categoria.limpio
        } else {
            modelContext.insert(Producto(nombre: nombre.limpio, categoria: categoria.limpio,
                                         stock: stock, costoPromedio: costo))
        }
        try? modelContext.save()
        dismiss()
    }
}
