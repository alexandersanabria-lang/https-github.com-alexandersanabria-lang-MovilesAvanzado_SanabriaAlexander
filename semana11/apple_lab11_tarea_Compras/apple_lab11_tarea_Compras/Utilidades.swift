import Foundation
import SwiftUI

// MARK: - Formato de montos, fechas y textos

extension Double {
    /// 1416.0 -> "S/ 1,416.00"
    var soles: String {
        "S/ " + self.formatted(.number.precision(.fractionLength(2)).locale(Locale(identifier: "en_US")))
    }
}

extension Date {
    /// "18 nov 2026"
    var corta: String {
        formatted(.dateTime.day().month(.abbreviated).year())
    }
}

extension String {
    /// Quita espacios al inicio y al final
    var limpio: String { trimmingCharacters(in: .whitespacesAndNewlines) }
}

// MARK: - Reglas de negocio

enum ServicioCompras {
    static let limiteAprobacion = 5000.0   // R2
    static let tasaIGV = 0.18              // R1

    /// R3: costo promedio ponderado
    static func nuevoCostoPromedio(stock: Int, costoPromedio: Double,
                                   cantidad: Int, costoUnitario: Double) -> Double {
        let unidades = stock + cantidad
        guard unidades > 0 else { return costoUnitario }
        return (Double(stock) * costoPromedio + Double(cantidad) * costoUnitario) / Double(unidades)
    }

    /// Se llama cuando una compra queda Aprobada: actualiza costo promedio y stock
    static func aplicarEfectos(de compra: Compra) {
        guard let producto = compra.producto else { return }
        producto.costoPromedio = nuevoCostoPromedio(
            stock: producto.stock,
            costoPromedio: producto.costoPromedio,
            cantidad: compra.cantidad,
            costoUnitario: compra.costoUnitario
        )
        producto.stock += compra.cantidad
    }
}

// MARK: - Valores calculados

extension Proveedor {
    var comprasAprobadas: [Compra] { compras.filter { $0.estado == "Aprobada" } }
    var totalComprado: Double { comprasAprobadas.reduce(0) { $0 + $1.total } }
    var porPagar: Double {
        comprasAprobadas.filter { $0.alCredito && !$0.pagada }.reduce(0) { $0 + $1.total }
    }
}

extension Producto {
    /// Verde más de 10, ámbar de 6 a 10, rojo 5 o menos
    var colorStock: Color {
        if stock > 10 { return .green }
        if stock >= 6 { return .orange }
        return .red
    }
}

extension Compra {
    var colorEstado: Color {
        switch estado {
        case "Aprobada": return .green
        case "Rechazada": return .red
        default: return .orange
        }
    }
}
