import Foundation


// Representa el estado actual de una línea del Metro
enum EstadoLinea: String {
    case operativa = "Operativa"
    case operacionParcial = "Operación parcial / en construcción"
    case planificacion = "En planificación"
}


// Representa una línea del Metro de Lima
struct LineaMetro {
    let numero: Int
    let nombre: String
    let estado: EstadoLinea
    let estaciones: [String]
    let descripcion: String
}




// Línea 1
let linea1 = LineaMetro(
    numero: 1,
    nombre: "Línea 1",
    estado: .operativa,
    estaciones: [
        "Villa El Salvador",
        "Parque Industrial",
        "Pumacahua",
        "Villa María",
        "María Auxiliadora",
        "San Juan",
        "Atocongo",
        "Jorge Chávez",
        "Ayacucho",
        "Cabitos",
        "Angamos",
        "San Borja Sur",
        "La Cultura",
        "Arriola",
        "Gamarra",
        "Miguel Grau",
        "El Ángel",
        "Presbítero Maestro",
        "Caja de Agua",
        "Pirámide del Sol",
        "Los Jardines",
        "Los Postes",
        "San Carlos",
        "San Martín",
        "Santa Rosa",
        "Bayóvar"
    ],
    descripcion: "Recorrido entre Villa El Salvador y San Juan de Lurigancho."
)


// Línea 2
let linea2 = LineaMetro(
    numero: 2,
    nombre: "Línea 2",
    estado: .operacionParcial,
    estaciones: [
        "Evitamiento",
        "Óvalo Santa Anita",
        "Colectora Industrial",
        "Hermilio Valdizán",
        "Mercado Santa Anita"
    ],
    descripcion: "Línea en implementación progresiva."
)


// Línea 3
let linea3 = LineaMetro(
    numero: 3,
    nombre: "Línea 3",
    estado: .planificacion,
    estaciones: [],
    descripcion: "Línea considerada dentro de la futura red del Metro."
)


// Línea 4
let linea4 = LineaMetro(
    numero: 4,
    nombre: "Línea 4",
    estado: .planificacion,
    estaciones: [],
    descripcion: "Línea considerada dentro de la futura red del Metro."
)


// Línea 5
let linea5 = LineaMetro(
    numero: 5,
    nombre: "Línea 5",
    estado: .planificacion,
    estaciones: [],
    descripcion: "Línea considerada dentro de la futura red del Metro."
)


// Línea 6
let linea6 = LineaMetro(
    numero: 6,
    nombre: "Línea 6",
    estado: .planificacion,
    estaciones: [],
    descripcion: "Línea considerada dentro de la futura red del Metro."
)



// Diccionario:
// clave   -> número de línea
// valor   -> información completa de la línea

let lineasMetro: [Int: LineaMetro] = [
    1: linea1,
    2: linea2,
    3: linea3,
    4: linea4,
    5: linea5,
    6: linea6
]



// Normaliza el texto para permitir búsquedas
// sin importar mayúsculas, minúsculas o tildes.
func normalizarTexto(_ texto: String) -> String {
    return texto
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .folding(options: .diacriticInsensitive, locale: .current)
        .lowercased()
}


// Busca una línea por su número.
func buscarLinea(numero: Int) -> LineaMetro? {
    return lineasMetro[numero]
}


// Busca una estación en todas las líneas registradas.
// Devuelve el nombre original de la estación si la encuentra.
func obtenerNombreEstacion(_ nombreIngresado: String) -> String? {

    let nombreNormalizado = normalizarTexto(nombreIngresado)

    for linea in lineasMetro.values {

        for estacion in linea.estaciones {

            if normalizarTexto(estacion) == nombreNormalizado {
                return estacion
            }
        }
    }

    return nil
}


// Obtiene las líneas a las que pertenece una estación.
// Se utiliza Set para evitar valores repetidos.
func obtenerLineasDeEstacion(_ nombreEstacion: String) -> Set<Int> {

    var lineasEncontradas = Set<Int>()

    let estacionBuscada = normalizarTexto(nombreEstacion)

    for linea in lineasMetro.values {

        for estacion in linea.estaciones {

            if normalizarTexto(estacion) == estacionBuscada {
                lineasEncontradas.insert(linea.numero)
            }
        }
    }

    return lineasEncontradas
}
