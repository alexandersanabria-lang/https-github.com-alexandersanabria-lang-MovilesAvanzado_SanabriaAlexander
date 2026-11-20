//  Created by Juan Leon - Jaime Gómez
//

import Foundation

// Codable: permite convertir entre esta estructura y datos JSON automáticamente.
// Identifiable: es un protocolo que permite que SwiftUI sepa cómo identificar cada elemento en una lista
// nonisolated: permite decodificar el JSON fuera del hilo principal (evita error en Xcode nuevo)
nonisolated struct User: Codable, Identifiable {
    let id: Int
    let name: String
}
