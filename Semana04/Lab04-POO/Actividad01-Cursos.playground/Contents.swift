import Foundation

// ===== ACTIVIDAD PROPUESTA 01 =====
// FACTURA DE CURSOS
// Estudiante: Alexander Sanabria

struct Curso {
    let nombre: String
    let precio: Double
}

class Estudiante {

    let nombre: String
    let dni: String
    let esAlumnoTecsup: Bool
    var cursos: [Curso] = []

    init(nombre: String, dni: String, esAlumnoTecsup: Bool) {
        self.nombre = nombre
        self.dni = dni
        self.esAlumnoTecsup = esAlumnoTecsup
    }

    func agregarCurso(_ curso: Curso) {
        cursos.append(curso)
    }

    func calcularSubtotal() -> Double {

        var subtotal = 0.0

        for curso in cursos {
            subtotal += curso.precio
        }

        return subtotal
    }

    func mostrarFactura() {

        let subtotal = calcularSubtotal()
        let igv = subtotal * 0.18
        let totalConIGV = subtotal + igv

        var descuentoCantidad = 0.0
        var descuentoTecsup = 0.0

        if cursos.count >= 3 {
            descuentoCantidad = totalConIGV * 0.10
        }

        if cursos.count >= 3 && esAlumnoTecsup {
            descuentoTecsup = 400.0
        }

        let totalFinal =
            totalConIGV
            - descuentoCantidad
            - descuentoTecsup

        print("FACTURA DE CURSOS")
        print("------------------------------")
        print("Estudiante: \(nombre)")
        print("DNI: \(dni)")

        if esAlumnoTecsup {
            print("Alumno de Tecsup: Si")
        } else {
            print("Alumno de Tecsup: No")
        }

        print("------------------------------")
        print("CURSOS:")

        for curso in cursos {
            print("- \(curso.nombre) - S/ \(curso.precio)")
        }

        print("------------------------------")
        print("Subtotal: S/ \(subtotal)")
        print("IGV (18%): S/ \(igv)")
        print("Total con IGV: S/ \(totalConIGV)")

        if descuentoCantidad > 0 {
            print("Descuento 10% por cantidad: -S/ \(descuentoCantidad)")
        }

        if descuentoTecsup > 0 {
            print("Descuento especial Tecsup: -S/ \(descuentoTecsup)")
        }

        print("------------------------------")
        print("TOTAL FINAL A PAGAR: S/ \(totalFinal)")
    }
}

let estudiante = Estudiante(
    nombre: "Alexander Sanabria",
    dni: "12345678",
    esAlumnoTecsup: true
)

let curso1 = Curso(
    nombre: "Swift Avanzado",
    precio: 450.0
)

let curso2 = Curso(
    nombre: "IA con Python",
    precio: 650.0
)

let curso3 = Curso(
    nombre: "Diseno UI/UX",
    precio: 600.0
)

let curso4 = Curso(
    nombre: "Desarrollo Web",
    precio: 550.0
)

estudiante.agregarCurso(curso1)
estudiante.agregarCurso(curso2)
estudiante.agregarCurso(curso3)
estudiante.agregarCurso(curso4)

estudiante.mostrarFactura()
