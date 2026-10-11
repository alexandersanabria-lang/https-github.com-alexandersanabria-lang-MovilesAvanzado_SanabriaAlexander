import UIKit

class Producto {

    let nombre: String
    let precio: Double
    var stock: Int

    init(nombre: String, precio: Double, stock: Int) {
        self.nombre = nombre
        self.precio = precio
        self.stock = stock
    }
}

class ItemCarrito {

    let producto: Producto
    var cantidad: Int

    init(producto: Producto, cantidad: Int) {
        self.producto = producto
        self.cantidad = cantidad
    }

    func subtotal() -> Double {
        return producto.precio * Double(cantidad)
    }
}

class CarritoModel {

    var items: [ItemCarrito] = []

    func agregar(producto: Producto, cantidad: Int) -> Bool {

        var cantidadActual = 0

        for item in items {

            if item.producto === producto {
                cantidadActual = item.cantidad
                break
            }
        }

        if cantidadActual + cantidad > producto.stock {
            return false
        }

        for item in items {

            if item.producto === producto {
                item.cantidad += cantidad
                return true
            }
        }

        let nuevoItem = ItemCarrito(
            producto: producto,
            cantidad: cantidad
        )

        items.append(nuevoItem)

        return true
    }

    func subtotal() -> Double {

        var total = 0.0

        for item in items {
            total += item.subtotal()
        }

        return total
    }

    func porcentajeDescuento() -> Double {

        let total = subtotal()

        if total >= 5000 {
            return 0.15

        } else if total >= 2000 {
            return 0.10

        } else if total >= 500 {
            return 0.05

        } else {
            return 0.0
        }
    }

    func cantidadTotal() -> Int {

        var total = 0

        for item in items {
            total += item.cantidad
        }

        return total
    }

    func vaciar() {
        items.removeAll()
    }
}

class ClienteModel {

    var apellido: String
    var nombre: String
    var dni: String

    init(apellido: String, nombre: String, dni: String) {
        self.apellido = apellido
        self.nombre = nombre
        self.dni = dni
    }
}
