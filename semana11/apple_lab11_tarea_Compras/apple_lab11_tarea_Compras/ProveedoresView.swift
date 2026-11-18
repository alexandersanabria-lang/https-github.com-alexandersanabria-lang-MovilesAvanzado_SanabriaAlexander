import SwiftUI
import SwiftData

// B4: Proveedores (consultar todos; crear/editar/borrar solo supervisor)
struct ProveedoresView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion
    @Query(sort: \Proveedor.nombre) private var proveedores: [Proveedor]

    @State private var busqueda = ""
    @State private var mostrarNuevo = false
    @State private var proveedorAEditar: Proveedor?
    @State private var mensajeAlerta: String?

    private var esSupervisor: Bool { sesion.usuario?.esSupervisor ?? false }

    private var filtrados: [Proveedor] {
        if busqueda.isEmpty { return proveedores }
        return proveedores.filter {
            $0.nombre.localizedCaseInsensitiveContains(busqueda) || $0.ruc.contains(busqueda)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                if filtrados.isEmpty {
                    Text(esSupervisor ? "Pulsa + para agregar un proveedor" : "Aún no hay proveedores")
                        .foregroundStyle(.secondary)
                }
                ForEach(filtrados) { proveedor in
                    Button {
                        if esSupervisor { proveedorAEditar = proveedor }
                    } label: {
                        FilaProveedor(proveedor: proveedor)
                    }
                    .buttonStyle(.plain)
                    .deleteDisabled(!esSupervisor)
                }
                .onDelete(perform: borrar)
            }
            .searchable(text: $busqueda, prompt: "Buscar por nombre o RUC")
            .navigationTitle("Proveedores")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { AvatarMenu() }
                if esSupervisor {
                    ToolbarItem(placement: .topBarTrailing) {       // ① + solo supervisor
                        Button { mostrarNuevo = true } label: { Image(systemName: "plus") }
                    }
                }
            }
            .sheet(isPresented: $mostrarNuevo) { ProveedorFormView(proveedor: nil) }
            .sheet(item: $proveedorAEditar) { ProveedorFormView(proveedor: $0) }
            .alert("No se puede eliminar",
                   isPresented: Binding(get: { mensajeAlerta != nil }, set: { if !$0 { mensajeAlerta = nil } })) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(mensajeAlerta ?? "")
            }
        }
    }

    // Borrado bloqueado si tiene compras (.deny)
    private func borrar(_ offsets: IndexSet) {
        for index in offsets {
            let proveedor = filtrados[index]
            if !proveedor.compras.isEmpty {
                mensajeAlerta = "No se puede eliminar: \(proveedor.nombre) tiene compras registradas."
            } else {
                modelContext.delete(proveedor)
            }
        }
        try? modelContext.save()
    }
}

// ② Fila con insignia "por pagar" o "Al día" y ③ total comprado
private struct FilaProveedor: View {
    let proveedor: Proveedor

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(proveedor.nombre).font(.headline)
                Text("RUC \(proveedor.ruc)").font(.caption).foregroundStyle(.secondary)
                Text("Total comprado: \(proveedor.totalComprado.soles)").font(.subheadline)
            }
            Spacer()
            if proveedor.porPagar > 0 {
                VStack(alignment: .trailing, spacing: 4) {
                    Insignia(texto: "por pagar", color: .orange)
                    Text(proveedor.porPagar.soles).font(.caption).foregroundStyle(.orange)
                }
            } else {
                Insignia(texto: "Al día", color: .green)
            }
        }
        .contentShape(Rectangle())
    }
}

// Formulario para crear o editar un proveedor (solo supervisor)
struct ProveedorFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let proveedor: Proveedor?

    @State private var nombre = ""
    @State private var ruc = ""

    private var rucValido: Bool { ruc.count == 11 && ruc.allSatisfy(\.isNumber) }
    private var esValido: Bool { !nombre.limpio.isEmpty && rucValido }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Razón social", text: $nombre)
                    TextField("RUC (11 dígitos)", text: $ruc)
                        .keyboardType(.numberPad)
                } header: {
                    Text("Proveedor")
                } footer: {
                    if !ruc.isEmpty && !rucValido {
                        Text("El RUC debe tener 11 dígitos").foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle(proveedor == nil ? "Nuevo proveedor" : "Editar proveedor")
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
                if let proveedor {
                    nombre = proveedor.nombre
                    ruc = proveedor.ruc
                }
            }
        }
    }

    private func guardar() {
        if let proveedor {
            proveedor.nombre = nombre.limpio
            proveedor.ruc = ruc
        } else {
            modelContext.insert(Proveedor(nombre: nombre.limpio, ruc: ruc))
        }
        try? modelContext.save()
        dismiss()
    }
}
