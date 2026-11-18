import Foundation
import Observation

// Guarda quién está conectado mientras la app está abierta
@Observable
final class Sesion {
    var usuario: Usuario?
}
