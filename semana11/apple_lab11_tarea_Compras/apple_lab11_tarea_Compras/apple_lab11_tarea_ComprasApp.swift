import SwiftUI
import SwiftData

@main
struct ComprasApp: App {
    @State private var sesion = Sesion()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(sesion)
        }
        .modelContainer(for: [Usuario.self, Proveedor.self, Producto.self, Compra.self])
    }
}
