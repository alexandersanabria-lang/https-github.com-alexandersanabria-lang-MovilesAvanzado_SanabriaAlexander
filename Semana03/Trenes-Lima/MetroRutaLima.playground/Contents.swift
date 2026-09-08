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



// RF01 - Mostrar todas las líneas registradas
func mostrarLineas() {

    print("\n======================================")
    print("          LÍNEAS DEL METRO")
    print("======================================")

    for numero in lineasMetro.keys.sorted() {

        if let linea = lineasMetro[numero] {

            print("\n\(linea.nombre)")
            print("Estado: \(linea.estado.rawValue)")
            print("Descripción: \(linea.descripcion)")
        }
    }
}


// RF02 - Mostrar estaciones de una línea
func mostrarEstacionesDeLinea(numero: Int) {

    guard let linea = buscarLinea(numero: numero) else {
        print("\n La línea ingresada no está registrada.")
        return
    }

    print("\n======================================")
    print("              \(linea.nombre.uppercased())")
    print("======================================")

    print("Estado: \(linea.estado.rawValue)")

    if linea.estaciones.isEmpty {

        print("\nEsta línea todavía no tiene estaciones habilitadas registradas.")
        return
    }

    print("\nEstaciones registradas:")

    for (indice, estacion) in linea.estaciones.enumerated() {
        print("\(indice + 1). \(estacion)")
    }

    print("\nTotal: \(linea.estaciones.count) estaciones")
}


// RF03 - Buscar una estación
func buscarEstacion(nombre: String) {

    guard let estacion = obtenerNombreEstacion(nombre) else {
        print("\n No se encontró la estación indicada.")
        return
    }

    let lineasEncontradas = obtenerLineasDeEstacion(estacion)

    print("\n======================================")
    print("          ESTACIÓN ENCONTRADA")
    print("======================================")

    print("\nEstación: \(estacion)")

    for numero in lineasEncontradas.sorted() {

        if let linea = buscarLinea(numero: numero) {
            print("Línea: \(linea.nombre)")
            print("Estado: \(linea.estado.rawValue)")
        }
    }
}


// RF04 - Consultar estado de una línea
func consultarEstadoLinea(numero: Int) {

    guard let linea = buscarLinea(numero: numero) else {
        print("\n La línea ingresada no está registrada.")
        return
    }

    print("\n======================================")
    print("          ESTADO DE LA LÍNEA")
    print("======================================")

    print("\n\(linea.nombre)")
    print("Estado: \(linea.estado.rawValue)")
    print("Descripción: \(linea.descripcion)")

    if linea.estaciones.isEmpty {
        print("Estaciones registradas: 0")
    } else {
        print("Estaciones registradas: \(linea.estaciones.count)")
    }
}




// Conexiones proyectadas entre líneas.
// Estas conexiones no se consideran operativas actualmente.
let conexionesProyectadas: [String: Set<Int>] = [
    "Cabitos": [1, 3],
    "La Cultura": [1, 4],
    "Mercado Santa Anita": [2, 4]
]


// Referencias cercanas a determinadas estaciones
let referenciasCercanas: [String: [String]] = [
    "Gamarra": [
        "Emporio Comercial de Gamarra"
    ],

    "La Cultura": [
        "Museo de la Nación",
        "Biblioteca Nacional del Perú"
    ],

    "Mercado Santa Anita": [
        "Gran Mercado Mayorista de Lima"
    ],

    "Hermilio Valdizán": [
        "Hospital Hermilio Valdizán"
    ],

    "Evitamiento": [
        "Puente Santa Anita"
    ]
]


// RF05 - Mostrar conexiones proyectadas
func mostrarConexiones() {

    print("\n======================================")
    print("       CONEXIONES ENTRE LÍNEAS")
    print("======================================")

    print("\nLas siguientes conexiones son proyectadas.")
    print("No necesariamente están disponibles actualmente.\n")

    for estacion in conexionesProyectadas.keys.sorted() {

        if let lineas = conexionesProyectadas[estacion] {

            let nombresLineas = lineas
                .sorted()
                .map { "Línea \($0)" }
                .joined(separator: " <-> ")

            print("Estación: \(estacion)")
            print("Conexión: \(nombresLineas)")
            print("--------------------------------------")
        }
    }
}


// RF07 - Buscar referencias cercanas
func buscarReferencia(_ texto: String) {

    let busqueda = normalizarTexto(texto)

    var resultados: [(estacion: String, lugar: String)] = []

    for (estacion, lugares) in referenciasCercanas {

        for lugar in lugares {

            let estacionNormalizada = normalizarTexto(estacion)
            let lugarNormalizado = normalizarTexto(lugar)

            if estacionNormalizada.contains(busqueda) ||
                lugarNormalizado.contains(busqueda) {

                resultados.append(
                    (estacion: estacion, lugar: lugar)
                )
            }
        }
    }

    if resultados.isEmpty {

        print("\n No se encontró una referencia relacionada.")
        return
    }

    print("\n======================================")
    print("         REFERENCIAS ENCONTRADAS")
    print("======================================")

    for resultado in resultados {

        print("\nLugar: \(resultado.lugar)")
        print("Estación cercana: \(resultado.estacion)")

        let lineas = obtenerLineasDeEstacion(resultado.estacion)

        for numero in lineas.sorted() {
            print("Línea: Línea \(numero)")
        }
    }
}




// Busca la posición de una estación dentro de una línea
func obtenerIndiceEstacion(
    _ estacion: String,
    en linea: LineaMetro
) -> Int? {

    let estacionBuscada = normalizarTexto(estacion)

    return linea.estaciones.firstIndex {
        normalizarTexto($0) == estacionBuscada
    }
}


// Busca si existe una conexión proyectada entre dos líneas
func buscarConexionProyectada(
    lineaOrigen: Int,
    lineaDestino: Int
) -> String? {

    for (estacion, lineas) in conexionesProyectadas {

        if lineas.contains(lineaOrigen) &&
            lineas.contains(lineaDestino) {

            return estacion
        }
    }

    return nil
}


// RF06 - Consultar una ruta entre dos estaciones
func consultarRuta(
    origen: String,
    destino: String
) {

    // Validar estación de origen
    guard let origenReal = obtenerNombreEstacion(origen) else {
        print("\n La estación de origen no está registrada.")
        return
    }

    // Validar estación de destino
    guard let destinoReal = obtenerNombreEstacion(destino) else {
        print("\n La estación de destino no está registrada.")
        return
    }

    // Evitar origen y destino iguales
    if normalizarTexto(origenReal) == normalizarTexto(destinoReal) {
        print("\n El origen y el destino son la misma estación.")
        return
    }

    let lineasOrigen = obtenerLineasDeEstacion(origenReal)
    let lineasDestino = obtenerLineasDeEstacion(destinoReal)

    print("\n======================================")
    print("             RESULTADO")
    print("======================================")

    print("\nOrigen: \(origenReal)")
    print("Destino: \(destinoReal)")


    

    let lineasComunes = lineasOrigen.intersection(lineasDestino)

    if let numeroLinea = lineasComunes.sorted().first,
       let linea = buscarLinea(numero: numeroLinea),
       let indiceOrigen = obtenerIndiceEstacion(origenReal, en: linea),
       let indiceDestino = obtenerIndiceEstacion(destinoReal, en: linea) {

        let cantidadTramos = abs(indiceDestino - indiceOrigen)

        print("\n RUTA DIRECTA")
        print("Utilice la \(linea.nombre).")

        // Determinar dirección
        if indiceDestino > indiceOrigen {

            if let ultimaEstacion = linea.estaciones.last {
                print("Dirección: \(ultimaEstacion)")
            }

        } else {

            if let primeraEstacion = linea.estaciones.first {
                print("Dirección: \(primeraEstacion)")
            }
        }

        print("Tramos de recorrido: \(cantidadTramos)")

        print("\nRecorrido:")

        // Recorrido hacia adelante
        if indiceOrigen < indiceDestino {

            for indice in indiceOrigen...indiceDestino {

                if indice == indiceOrigen {
                    print(" \(linea.estaciones[indice])")

                } else if indice == indiceDestino {
                    print(" \(linea.estaciones[indice])")

                } else {
                    print("• \(linea.estaciones[indice])")
                }
            }

        } else {

            // Recorrido hacia atrás
            for indice in stride(
                from: indiceOrigen,
                through: indiceDestino,
                by: -1
            ) {

                if indice == indiceOrigen {
                    print(" \(linea.estaciones[indice])")

                } else if indice == indiceDestino {
                    print(" \(linea.estaciones[indice])")

                } else {
                    print(" \(linea.estaciones[indice])")
                }
            }
        }

        return
    }


    

    for lineaOrigen in lineasOrigen {

        for lineaDestino in lineasDestino {

            if let conexion = buscarConexionProyectada(
                lineaOrigen: lineaOrigen,
                lineaDestino: lineaDestino
            ) {

                print("\n CONEXIÓN PROYECTADA")

                print(
                    "Existe una conexión proyectada entre " +
                    "Línea \(lineaOrigen) y Línea \(lineaDestino)."
                )

                print("Punto de conexión: \(conexion)")

                print(
                    "Esta conexión no se considera una ruta " +
                    "operativa actualmente."
                )

                return
            }
        }
    }


    

    print("\n No se encontró una ruta disponible con los datos registrados.")
}
