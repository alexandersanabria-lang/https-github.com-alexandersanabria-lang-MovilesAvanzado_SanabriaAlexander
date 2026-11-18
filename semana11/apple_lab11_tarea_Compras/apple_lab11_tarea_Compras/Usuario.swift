import Foundation
import SwiftData

@Model
final class Usuario {
    var nombre: String
    var usuario: String          // único, sin distinguir mayúsculas
    var clave: String            // mínimo 6 caracteres (solo práctica)
    var rol: String              // "Comprador" o "Supervisor"

    // Un usuario registra muchas compras. No se puede borrar si tiene compras.
    @Relationship(deleteRule: .deny, inverse: \Compra.comprador)
    var compras: [Compra] = []

    init(nombre: String, usuario: String, clave: String, rol: String) {
        self.nombre = nombre
        self.usuario = usuario
        self.clave = clave
        self.rol = rol
    }

    var esSupervisor: Bool { rol == "Supervisor" }

    // Iniciales para el avatar (ej. "Alexander Sanabria" -> "AS")
    var iniciales: String {
        nombre.split(separator: " ").prefix(2).compactMap { $0.first }.map { String($0) }.joined().uppercased()
    }
}
