import SwiftUI
import SwiftData

// B2: Crear cuenta
struct RegistroView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion

    @State private var nombre = ""
    @State private var usuario = ""
    @State private var clave = ""
    @State private var confirmar = ""
    @State private var rol = "Comprador"

    private let roles = ["Comprador", "Supervisor"]

    // El usuario se guarda en minúsculas: "MTorres" y "mtorres" son el mismo
    private var usuarioNormalizado: String { usuario.limpio.lowercased() }

    // ③ Usuario único: cuenta cuántos existen con ese usuario
    private var usuarioRepetido: Bool {
        let u = usuarioNormalizado
        guard !u.isEmpty else { return false }
        let descriptor = FetchDescriptor<Usuario>(predicate: #Predicate { $0.usuario == u })
        return ((try? modelContext.fetchCount(descriptor)) ?? 0) > 0
    }

    // Primera regla que no se cumple (nil = todo correcto)
    private var errorValidacion: String? {
        if nombre.limpio.isEmpty { return "Ingresa tu nombre completo" }
        if usuarioNormalizado.isEmpty { return "Ingresa un usuario" }
        if usuarioRepetido { return "El usuario ya existe" }
        if clave.count < 6 { return "La clave debe tener mínimo 6 caracteres" }
        if clave != confirmar { return "Las claves no coinciden" }
        return nil
    }

    var body: some View {
        Form {
            // ② Nombre completo
            Section("Datos personales") {
                TextField("Nombre completo", text: $nombre)
                    .textInputAutocapitalization(.words)
            }

            // ③ Usuario único, con aviso si ya existe
            Section {
                TextField("Usuario", text: $usuario)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            } header: {
                Text("Cuenta")
            } footer: {
                if usuarioRepetido {
                    Label("El usuario ya existe", systemImage: "xmark.circle.fill")
                        .foregroundStyle(.red)
                }
            }

            // ④ Clave (mínimo 6) y su confirmación
            Section {
                SecureField("Clave (mínimo 6)", text: $clave)
                SecureField("Confirmar clave", text: $confirmar)
            } header: {
                Text("Clave")
            } footer: {
                if !confirmar.isEmpty && clave != confirmar {
                    Text("Las claves no coinciden").foregroundStyle(.red)
                } else if !clave.isEmpty && clave.count < 6 {
                    Text("Mínimo 6 caracteres").foregroundStyle(.red)
                }
            }

            // ⑤ Rol
            Section("Rol") {
                Picker("Rol", selection: $rol) {
                    ForEach(roles, id: \.self) { Text($0) }
                }
                .pickerStyle(.segmented)
            }

            // ⑥ Registrarme (entra directo a la app)
            Section {
                Button {
                    registrar()
                } label: {
                    Text("Registrarme")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .disabled(errorValidacion != nil)
            } footer: {
                if let errorValidacion {
                    Text(errorValidacion)
                }
            }
        }
        .navigationTitle("Crear cuenta")   // ① el botón "atrás" vuelve al login
    }

    private func registrar() {
        guard errorValidacion == nil else { return }
        let nuevo = Usuario(nombre: nombre.limpio, usuario: usuarioNormalizado, clave: clave, rol: rol)
        modelContext.insert(nuevo)
        try? modelContext.save()
        sesion.usuario = nuevo     // entra directo a la app
    }
}
