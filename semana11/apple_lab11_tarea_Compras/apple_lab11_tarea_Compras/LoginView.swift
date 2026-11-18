import SwiftUI
import SwiftData

// B1: Inicio de sesión
struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion

    @State private var usuario = ""
    @State private var clave = ""
    @State private var mensajeError: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()

                // ① Logo y nombre
                Image(systemName: "shippingbox.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(.white)
                    .frame(width: 110, height: 110)
                    .background(Color.indigo.gradient, in: RoundedRectangle(cornerRadius: 26))
                Text("Compras")
                    .font(.largeTitle.bold())
                Text("Distribuidora · Tecsup")
                    .foregroundStyle(.secondary)

                // ② Usuario  ③ Clave oculta
                VStack(spacing: 12) {
                    TextField("Usuario", text: $usuario)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding()
                        .background(.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 12))
                    SecureField("Clave", text: $clave)
                        .padding()
                        .background(.gray.opacity(0.12), in: RoundedRectangle(cornerRadius: 12))
                }
                .padding(.top, 12)

                // ④ Mensaje de error genérico
                if let mensajeError {
                    Label(mensajeError, systemImage: "exclamationmark.triangle.fill")
                        .foregroundStyle(.red)
                        .font(.subheadline)
                }

                // ⑤ Ingresar
                Button {
                    ingresar()
                } label: {
                    Text("Ingresar")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.borderedProminent)
                .tint(.indigo)
                .disabled(usuario.isEmpty || clave.isEmpty)

                // ⑥ Ir a Crear cuenta
                NavigationLink("¿No tienes cuenta? Crear cuenta") {
                    RegistroView()
                }

                Spacer()
            }
            .padding(24)
        }
    }

    private func ingresar() {
        // #Predicate necesita los valores en constantes (let) antes de usarlos
        let u = usuario.limpio.lowercased()
        let c = clave
        let descriptor = FetchDescriptor<Usuario>(
            predicate: #Predicate { $0.usuario == u && $0.clave == c }
        )

        if let encontrado = try? modelContext.fetch(descriptor).first {
            mensajeError = nil
            sesion.usuario = encontrado          // ContentView cambia solo a las pestañas
        } else {
            mensajeError = "Usuario o clave incorrectos"   // no dice cuál falló
        }
    }
}
