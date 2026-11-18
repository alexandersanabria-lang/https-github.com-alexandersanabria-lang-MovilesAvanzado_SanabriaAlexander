import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(Sesion.self) private var sesion

    var body: some View {
        if let usuario = sesion.usuario {
            Text("Hola \(usuario.nombre)")       // aquí irá el TabView por rol
        } else {
            Text("Aquí irá el Login")            // aquí irá LoginView
        }
    }
}

#Preview {
    ContentView()
        .environment(Sesion())
        .modelContainer(for: [Usuario.self, Proveedor.self, Producto.self, Compra.self], inMemory: true)
}
