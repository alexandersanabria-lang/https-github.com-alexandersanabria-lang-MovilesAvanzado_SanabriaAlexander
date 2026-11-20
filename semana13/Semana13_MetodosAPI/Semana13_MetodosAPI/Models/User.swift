//  Created by Juan Leon - Jaime Gómez
// Utilizando los métodos POST - PUT - DELETE

import Foundation

// nonisolated: permite codificar/decodificar el JSON fuera del hilo principal (evita error en Xcode nuevo)
nonisolated struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
}
