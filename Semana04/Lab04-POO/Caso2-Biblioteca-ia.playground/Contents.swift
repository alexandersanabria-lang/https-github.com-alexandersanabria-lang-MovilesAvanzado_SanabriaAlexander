import Foundation // Importa Foundation para usar funcionalidades básicas de Swift.

// ===== CASO 2 — PARTE B: BIBLIOTECA (CON IA) =====
// Docente: Juan León
// Estudiante: Alexander Sanabria
// Herramienta utilizada: ChatGPT

enum EstadoLibro { // Define los posibles estados que puede tener un libro.
    case disponible // Indica que el libro puede ser prestado.
    case prestado // Indica que el libro ya fue prestado.
}

struct Libro { // Representa los datos de un libro.
    let titulo: String // Guarda el título del libro.
    let autor: String // Guarda el nombre del autor.
    var estado: EstadoLibro = .disponible // Todo libro empieza disponible.
}

class Biblioteca { // Representa una biblioteca que administra varios libros.

    var libros: [Libro] = [] // Guarda los libros registrados en un arreglo.

    func agregar(libro: Libro) { // Recibe un libro para agregarlo a la biblioteca.
        libros.append(libro) // Añade el libro al final del arreglo.
    }

    func prestar(titulo: String) -> Bool { // Intenta prestar un libro según su título.

        for i in 0..<libros.count { // Recorre el arreglo utilizando sus índices.

            if libros[i].titulo == titulo { // Comprueba si encontró el libro solicitado.

                if libros[i].estado == .disponible { // Comprueba si todavía está disponible.

                    libros[i].estado = .prestado // Modifica el struct directamente dentro del arreglo.
                    print("Préstamo aprobado: \(titulo)") // Informa que el préstamo fue realizado.
                    return true // Indica que la operación fue exitosa.

                } else { // Se ejecuta cuando el libro ya está prestado.

                    print("Error: \(titulo) ya está prestado") // Muestra el error correspondiente.
                    return false // Indica que el préstamo no pudo realizarse.
                }
            }
        }

        print("Error: no existe \(titulo)") // Se ejecuta si no se encontró el título.
        return false // Indica que la operación falló.
    }

    func devolver(titulo: String) -> Bool { // Intenta devolver un libro según su título.

        for i in 0..<libros.count { // Recorre todos los libros utilizando índices.

            if libros[i].titulo == titulo { // Comprueba si encontró el libro.

                if libros[i].estado == .prestado { // Verifica que realmente esté prestado.

                    libros[i].estado = .disponible // Cambia su estado dentro del arreglo.
                    print("Devolución registrada: \(titulo)") // Confirma la devolución.
                    return true // Indica que la devolución fue exitosa.

                } else { // Se ejecuta si el libro ya estaba disponible.

                    print("Error: \(titulo) ya está disponible") // Muestra el error.
                    return false // Indica que no fue posible realizar la devolución.
                }
            }
        }

        print("Error: no existe \(titulo)") // Informa que el libro no existe.
        return false // Indica que la operación falló.
    }

    func inventario() { // Muestra el estado actual de todos los libros.

        print("===== INVENTARIO =====") // Imprime el título de la sección.

        for libro in libros { // Recorre todos los libros registrados.

            switch libro.estado { // Evalúa el estado del libro.

            case .disponible: // Se ejecuta cuando está disponible.
                print("\(libro.titulo) (\(libro.autor)) - disponible") // Muestra sus datos y estado.

            case .prestado: // Se ejecuta cuando está prestado.
                print("\(libro.titulo) (\(libro.autor)) - prestado") // Muestra sus datos y estado.
            }
        }
    }
}

let biblioteca = Biblioteca() // Crea una única biblioteca para realizar la simulación.

let libro1 = Libro( // Crea el primer libro.
    titulo: "Cien años de soledad", // Define su título.
    autor: "Gabriel García Márquez" // Define su autor.
)

let libro2 = Libro( // Crea el segundo libro.
    titulo: "La ciudad y los perros", // Define su título.
    autor: "Mario Vargas Llosa" // Define su autor.
)

let libro3 = Libro( // Crea el tercer libro.
    titulo: "El Quijote", // Define su título.
    autor: "Miguel de Cervantes" // Define su autor.
)

biblioteca.agregar(libro: libro1) // Agrega el primer libro al arreglo.
biblioteca.agregar(libro: libro2) // Agrega el segundo libro al arreglo.
biblioteca.agregar(libro: libro3) // Agrega el tercer libro al arreglo.

biblioteca.prestar(titulo: "La ciudad y los perros") // Realiza el primer préstamo.
biblioteca.prestar(titulo: "La ciudad y los perros") // Intenta prestar nuevamente el mismo libro.
biblioteca.devolver(titulo: "La ciudad y los perros") // Registra la devolución del libro.
biblioteca.prestar(titulo: "El Quijote") // Presta El Quijote.
biblioteca.prestar(titulo: "El Principito") // Intenta prestar un libro que no existe.
biblioteca.inventario() // Muestra el inventario final.
