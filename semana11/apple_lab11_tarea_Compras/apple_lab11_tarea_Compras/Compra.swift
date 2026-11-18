import Foundation
import SwiftData

@Model
final class Compra {
    var fecha: Date
    var cantidad: Int
    var costoUnitario: Double
    var igv: Double
    var total: Double
    var alCredito: Bool
    var vence: Date
    var estado: String           // "Pendiente", "Aprobada" o "Rechazada"
    var pagada: Bool
    var motivoRechazo: String?

    // Lado "uno" de las relaciones (la inversa está en cada clase)
    var comprador: Usuario?
    var proveedor: Proveedor?
    var producto: Producto?

    // Las relaciones se asignan DESPUÉS de insertar la compra en el contexto
    init(cantidad: Int, costoUnitario: Double, alCredito: Bool, fecha: Date = .now) {
        let subtotal = Double(cantidad) * costoUnitario
        let igvCalculado = subtotal * 0.18                 // R1: IGV 18 % (crédito fiscal)
        let totalCalculado = subtotal + igvCalculado

        self.fecha = fecha
        self.cantidad = cantidad
        self.costoUnitario = costoUnitario
        self.igv = igvCalculado
        self.total = totalCalculado
        self.alCredito = alCredito
        // R4: crédito vence a 30 días; contado vence el mismo día
        self.vence = alCredito ? Calendar.current.date(byAdding: .day, value: 30, to: fecha)! : fecha
        // R2: desde S/ 5,000 queda Pendiente de aprobación
        self.estado = totalCalculado < 5000 ? "Aprobada" : "Pendiente"
        // R4: contado queda pagada; crédito queda por pagar
        self.pagada = !alCredito
        self.motivoRechazo = nil
    }

    var subtotal: Double { Double(cantidad) * costoUnitario }

    // R4: aprobada, a crédito, sin pagar y con fecha pasada
    var estaVencida: Bool {
        estado == "Aprobada" && alCredito && !pagada && vence < .now
    }
}
