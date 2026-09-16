import Foundation

// ===== CASO 2 — PARTE A: BIBLIOTECA (SIN IA) =====
// Docente: Juan León
// Estudiante: Alexander Sanabria


// =====================================================
// ENUM
// =====================================================

enum EstadoLibro {
    case disponible
    case prestado
}


// =====================================================
// STRUCT
// =====================================================

struct Libro {
    let titulo: String
    let autor: String
    var estado: EstadoLibro = .disponible
}


// =====================================================
// CLASE BIBLIOTECA
// =====================================================

class Biblioteca {

    var libros: [Libro] = []

    // Agrega un libro al arreglo
    func agregar(libro: Libro) {
        libros.append(libro)
    }


    // Busca un libro y realiza el préstamo
    func prestar(titulo: String) -> Bool {

        for i in 0..<libros.count {

            if libros[i].titulo == titulo {

                if libros[i].estado == .disponible {

                    libros[i].estado = .prestado

                    print("Préstamo aprobado: \(titulo)")

                    return true

                } else {

                    print("Error: \(titulo) ya está prestado")

                    return false
                }
            }
        }

        print("Error: no existe \(titulo)")

        return false
    }


    // Busca un libro y registra su devolución
    func devolver(titulo: String) -> Bool {

        for i in 0..<libros.count {

            if libros[i].titulo == titulo {

                if libros[i].estado == .prestado {

                    libros[i].estado = .disponible

                    print("Devolución registrada: \(titulo)")

                    return true

                } else {

                    print("Error: \(titulo) ya está disponible")

                    return false
                }
            }
        }

        print("Error: no existe \(titulo)")

        return false
    }


    // Muestra todos los libros de la biblioteca
    func inventario() {

        print("===== INVENTARIO =====")

        for libro in libros {

            switch libro.estado {

            case .disponible:
                print("\(libro.titulo) (\(libro.autor)) - disponible")

            case .prestado:
                print("\(libro.titulo) (\(libro.autor)) - prestado")
            }
        }
    }
}


// =====================================================
// SIMULACIÓN
// =====================================================

let biblioteca = Biblioteca()


// Agregamos los tres libros solicitados

biblioteca.agregar(
    libro: Libro(
        titulo: "Cien años de soledad",
        autor: "Gabriel García Márquez"
    )
)

biblioteca.agregar(
    libro: Libro(
        titulo: "La ciudad y los perros",
        autor: "Mario Vargas Llosa"
    )
)

biblioteca.agregar(
    libro: Libro(
        titulo: "El Quijote",
        autor: "Miguel de Cervantes"
    )
)


// Préstamo de La ciudad y los perros

biblioteca.prestar(
    titulo: "La ciudad y los perros"
)


// Intentamos prestarlo nuevamente

biblioteca.prestar(
    titulo: "La ciudad y los perros"
)


// Devolvemos La ciudad y los perros

biblioteca.devolver(
    titulo: "La ciudad y los perros"
)


// Prestamos El Quijote

biblioteca.prestar(
    titulo: "El Quijote"
)


// Intentamos prestar un libro que no existe

biblioteca.prestar(
    titulo: "El Principito"
)


// Mostramos el inventario final

biblioteca.inventario()
