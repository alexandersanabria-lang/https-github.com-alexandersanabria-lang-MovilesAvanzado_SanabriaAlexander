import Foundation


// Representa el estado actual de una línea del Metro
enum EstadoLinea: String {
    case operativa = "Operativa actualmente"
    case simulada = "Disponible en la simulación"
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


let linea2 = LineaMetro(
    numero: 2,
    nombre: "Línea 2",
    estado: .simulada,
    estaciones: [
        "Puerto del Callao",
        "Buenos Aires",
        "Juan Pablo II",
        "Insurgentes",
        "Carmen de la Legua",
        "Óscar R. Benavides",
        "San Marcos",
        "Elio",
        "La Alborada",
        "Tingo María",
        "Parque Murillo",
        "Plaza Bolognesi",
        "Estación Central",
        "Manco Cápac",
        "Cangallo",
        "28 de Julio",
        "Nicolás Ayllón",
        "Circunvalación",
        "San Juan de Dios",
        "Evitamiento",
        "Óvalo Santa Anita",
        "Colectora Industrial",
        "Hermilio Valdizán",
        "Mercado Santa Anita",
        "Vista Alegre",
        "Prolongación Javier Prado",
        "Municipalidad de Ate"
    ],
    descripcion: "Simulación del recorrido completo entre Callao y Ate."
)

let linea3 = LineaMetro(
    numero: 3,
    nombre: "Línea 3",
    estado: .simulada,
    estaciones: [
        "Comas",
        "Naranjal",
        "Estación Central",
        "Parque de la Reserva",
        "Conde de San Isidro",
        "Miraflores",
        "Cabitos",
        "Los Héroes"
    ],
    descripcion: "Simulación del eje Lima Norte - Centro - Lima Sur."
)

let linea4 = LineaMetro(
    numero: 4,
    nombre: "Línea 4",
    estado: .simulada,
    estaciones: [
        "Carmen de la Legua",
        "Aeropuerto",
        "Conde de San Isidro",
        "La Cultura",
        "Mercado Santa Anita"
    ],
    descripcion: "Simulación del corredor Callao - Lima - Santa Anita."
)

let linea5 = LineaMetro(
    numero: 5,
    nombre: "Línea 5",
    estado: .simulada,
    estaciones: [
        "Surquillo",
        "Parque Reducto 2",
        "Huaca Pucllana",
        "Parque Central",
        "Municipalidad de Miraflores",
        "Barranco",
        "Chorrillos",
        "Villa El Salvador"
    ],
    descripcion: "Simulación del corredor Miraflores - Chorrillos - Lima Sur."
)

let linea6 = LineaMetro(
    numero: 6,
    nombre: "Línea 6",
    estado: .simulada,
    estaciones: [
        "Túpac Amaru",
        "Naranjal",
        "Canto Grande",
        "Huarangal",
        "Las Flores",
        "La Molina",
        "Camacho",
        "Universidad de Lima",
        "Atocongo"
    ],
    descripcion: "Simulación del corredor Independencia - Lima Este - Surco."
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

    guard let estacion =
        obtenerNombreEstacion(nombre)
    else {

        print("\n No se encontró la estación indicada.")
        return
    }


    let lineasEncontradas =
        obtenerLineasDeEstacion(estacion)


    print("\n======================================")
    print("        INFORMACIÓN DE ESTACIÓN")
    print("======================================")

    print("\nEstación: \(estacion)")


    for numero in lineasEncontradas.sorted() {

        guard let linea =
            buscarLinea(numero: numero),

              let posicion =
            obtenerIndiceEstacion(
                estacion,
                en: linea
            )

        else {
            continue
        }


        print("\nLínea: \(linea.nombre)")
        print("Estado: \(linea.estado.rawValue)")

        print(
            "Posición: \(posicion + 1) de " +
            "\(linea.estaciones.count)"
        )


        if posicion > 0 {

            print(
                "Estación anterior: " +
                linea.estaciones[posicion - 1]
            )

        } else {

            print("Estación anterior: Terminal")
        }


        if posicion < linea.estaciones.count - 1 {

            print(
                "Estación siguiente: " +
                linea.estaciones[posicion + 1]
            )

        } else {

            print("Estación siguiente: Terminal")
        }


        if let primera = linea.estaciones.first,
           let ultima = linea.estaciones.last {

            print("Terminal 1: \(primera)")
            print("Terminal 2: \(ultima)")
        }
    }


    let lugares =
        lugaresInteres.filter {

            normalizarTexto($0.estacion) ==
            normalizarTexto(estacion)
        }


    if !lugares.isEmpty {

        print("\nLugares cercanos:")

        for lugar in lugares {

            print("- \(lugar.nombre)")
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
// =====================================================
// MARK: - ENLACES CERCANOS ENTRE LÍNEAS
// =====================================================

struct EnlaceCercano {
    let lineaA: Int
    let estacionA: String

    let lineaB: Int
    let estacionB: String

    let indicacion: String
}


let enlacesCercanos: [EnlaceCercano] = [

    EnlaceCercano(
        lineaA: 1,
        estacionA: "Gamarra",
        lineaB: 2,
        estacionB: "28 de Julio",
        indicacion: "Baja en Gamarra y dirígete hacia la estación 28 de Julio de la Línea 2."
    ),

    EnlaceCercano(
        lineaA: 1,
        estacionA: "Cabitos",
        lineaB: 3,
        estacionB: "Cabitos",
        indicacion: "Realiza el cambio de línea en el sector de Cabitos."
    ),

    EnlaceCercano(
        lineaA: 1,
        estacionA: "La Cultura",
        lineaB: 4,
        estacionB: "La Cultura",
        indicacion: "Continúa hacia el acceso correspondiente a la Línea 4 en La Cultura."
    ),

    EnlaceCercano(
        lineaA: 1,
        estacionA: "Villa El Salvador",
        lineaB: 5,
        estacionB: "Villa El Salvador",
        indicacion: "Dirígete hacia el acceso de la Línea 5 en Villa El Salvador."
    ),

    EnlaceCercano(
        lineaA: 1,
        estacionA: "Atocongo",
        lineaB: 6,
        estacionB: "Atocongo",
        indicacion: "Continúa hacia el acceso de la Línea 6 en el sector de Atocongo."
    ),

    EnlaceCercano(
        lineaA: 2,
        estacionA: "Estación Central",
        lineaB: 3,
        estacionB: "Estación Central",
        indicacion: "Realiza el cambio de línea en el sector de Estación Central."
    ),

    EnlaceCercano(
        lineaA: 2,
        estacionA: "Carmen de la Legua",
        lineaB: 4,
        estacionB: "Carmen de la Legua",
        indicacion: "Dirígete hacia el acceso de la Línea 4 en Carmen de la Legua."
    ),

    EnlaceCercano(
        lineaA: 2,
        estacionA: "Mercado Santa Anita",
        lineaB: 4,
        estacionB: "Mercado Santa Anita",
        indicacion: "Continúa hacia el acceso cercano correspondiente a la Línea 4."
    ),

    EnlaceCercano(
        lineaA: 3,
        estacionA: "Conde de San Isidro",
        lineaB: 4,
        estacionB: "Conde de San Isidro",
        indicacion: "Realiza el cambio entre las Líneas 3 y 4 en este sector."
    ),

    EnlaceCercano(
        lineaA: 3,
        estacionA: "Miraflores",
        lineaB: 5,
        estacionB: "Municipalidad de Miraflores",
        indicacion: "Desde la estación Miraflores dirígete hacia Municipalidad de Miraflores para continuar por Línea 5."
    ),

    EnlaceCercano(
        lineaA: 4,
        estacionA: "Conde de San Isidro",
        lineaB: 6,
        estacionB: "Camacho",
        indicacion: "Utiliza la conexión urbana simulada hacia Camacho para continuar por Línea 6."
    )
]

func buscarEnlace(
    entre lineaA: Int,
    y lineaB: Int
) -> EnlaceCercano? {

    return enlacesCercanos.first {

        ($0.lineaA == lineaA && $0.lineaB == lineaB) ||
        ($0.lineaA == lineaB && $0.lineaB == lineaA)
    }
}


func otraLinea(
    del enlace: EnlaceCercano,
    desde linea: Int
) -> Int {

    if enlace.lineaA == linea {
        return enlace.lineaB
    }

    return enlace.lineaA
}


func estacionSalida(
    del enlace: EnlaceCercano,
    para linea: Int
) -> String {

    if enlace.lineaA == linea {
        return enlace.estacionA
    }

    return enlace.estacionB
}


func estacionEntrada(
    del enlace: EnlaceCercano,
    hacia linea: Int
) -> String {

    if enlace.lineaA == linea {
        return enlace.estacionA
    }

    return enlace.estacionB
}

func buscarCaminoDeLineas(
    desde inicio: Int,
    hasta destino: Int
) -> [Int]? {

    if inicio == destino {
        return [inicio]
    }

    var cola: [[Int]] = [[inicio]]

    var visitadas: Set<Int> = [inicio]


    while !cola.isEmpty {

        let caminoActual = cola.removeFirst()

        guard let lineaActual = caminoActual.last else {
            continue
        }


        for enlace in enlacesCercanos {

            guard enlace.lineaA == lineaActual ||
                  enlace.lineaB == lineaActual
            else {
                continue
            }


            let siguiente = otraLinea(
                del: enlace,
                desde: lineaActual
            )


            if visitadas.contains(siguiente) {
                continue
            }


            let nuevoCamino =
                caminoActual + [siguiente]


            if siguiente == destino {
                return nuevoCamino
            }


            visitadas.insert(siguiente)

            cola.append(nuevoCamino)
        }
    }


    return nil
}




// Referencias cercanas a determinadas estaciones
// =====================================================
// MARK: - LUGARES DE INTERÉS
// =====================================================

struct LugarInteres {

    let nombre: String

    let estacion: String

    let linea: Int

    let palabrasClave: [String]
}


let lugaresInteres: [LugarInteres] = [

    LugarInteres(
        nombre: "Emporio Comercial de Gamarra",
        estacion: "Gamarra",
        linea: 1,
        palabrasClave: [
            "gamarra",
            "emporio",
            "ropa",
            "compras"
        ]
    ),

    LugarInteres(
        nombre: "Biblioteca Nacional del Perú",
        estacion: "La Cultura",
        linea: 1,
        palabrasClave: [
            "biblioteca",
            "biblioteca nacional",
            "bn",
            "san borja"
        ]
    ),

    LugarInteres(
        nombre: "Gran Teatro Nacional",
        estacion: "La Cultura",
        linea: 1,
        palabrasClave: [
            "teatro",
            "gran teatro",
            "cultura"
        ]
    ),

    LugarInteres(
        nombre: "Mall del Sur",
        estacion: "Atocongo",
        linea: 1,
        palabrasClave: [
            "mall del sur",
            "mall",
            "centro comercial"
        ]
    ),

    LugarInteres(
        nombre: "Universidad Nacional Mayor de San Marcos",
        estacion: "San Marcos",
        linea: 2,
        palabrasClave: [
            "san marcos",
            "universidad",
            "unmsm"
        ]
    ),

    LugarInteres(
        nombre: "Real Plaza Centro Cívico",
        estacion: "Estación Central",
        linea: 2,
        palabrasClave: [
            "real plaza",
            "centro civico",
            "centro comercial"
        ]
    ),

    LugarInteres(
        nombre: "Mall Aventura Santa Anita",
        estacion: "Evitamiento",
        linea: 2,
        palabrasClave: [
            "mall aventura",
            "mall santa anita",
            "mall aventura santa anita",
            "centro comercial santa anita",
            "santa anita"
        ]
    ),

    LugarInteres(
        nombre: "Mercado Mayorista de Santa Anita",
        estacion: "Mercado Santa Anita",
        linea: 2,
        palabrasClave: [
            "mercado",
            "mercado mayorista",
            "mayorista santa anita"
        ]
    ),

    LugarInteres(
        nombre: "Circuito Mágico del Agua",
        estacion: "Parque de la Reserva",
        linea: 3,
        palabrasClave: [
            "circuito magico",
            "circuito magico del agua",
            "parque de la reserva",
            "fuentes"
        ]
    ),

    LugarInteres(
        nombre: "Centro de Miraflores",
        estacion: "Miraflores",
        linea: 3,
        palabrasClave: [
            "miraflores",
            "centro miraflores"
        ]
    ),

    LugarInteres(
        nombre: "Aeropuerto Internacional Jorge Chávez",
        estacion: "Aeropuerto",
        linea: 4,
        palabrasClave: [
            "aeropuerto",
            "jorge chavez",
            "vuelo"
        ]
    ),

    LugarInteres(
        nombre: "Huaca Pucllana",
        estacion: "Huaca Pucllana",
        linea: 5,
        palabrasClave: [
            "huaca",
            "huaca pucllana",
            "arqueologia"
        ]
    ),

    LugarInteres(
        nombre: "Centro de Barranco",
        estacion: "Barranco",
        linea: 5,
        palabrasClave: [
            "barranco",
            "puente de los suspiros",
            "turismo"
        ]
    ),

    LugarInteres(
        nombre: "Universidad de Lima",
        estacion: "Universidad de Lima",
        linea: 6,
        palabrasClave: [
            "universidad de lima",
            "ulima",
            "universidad"
        ]
    ),

    LugarInteres(
        nombre: "Camacho",
        estacion: "Camacho",
        linea: 6,
        palabrasClave: [
            "camacho",
            "centro comercial",
            "la molina"
        ]
    )
]


// RF05 - Mostrar conexiones proyectadas
func mostrarConexiones() {

    print("\n======================================")
    print("        ENLACES ENTRE LÍNEAS")
    print("======================================")

    print("\nLa simulación permite cambiar de línea")
    print("mediante estaciones o accesos cercanos.\n")


    for (indice, enlace) in enlacesCercanos.enumerated() {

        print("\(indice + 1). Línea \(enlace.lineaA)")
        print("   \(enlace.estacionA)")

        print("        ↓")

        print("   \(enlace.estacionB)")
        print("   Línea \(enlace.lineaB)")

        print("   \(enlace.indicacion)")

        print("--------------------------------------")
    }
}


// RF07 - Buscar referencias cercanas
func buscarReferencia(_ texto: String) {

    let busqueda = normalizarTexto(texto)

    var resultados: [LugarInteres] = []


    for lugar in lugaresInteres {

        let coincideNombre =
            normalizarTexto(lugar.nombre)
                .contains(busqueda)


        let coincideEstacion =
            normalizarTexto(lugar.estacion)
                .contains(busqueda)


        let coincidePalabra =
            lugar.palabrasClave.contains {

                normalizarTexto($0)
                    .contains(busqueda)
            }


        if coincideNombre ||
           coincideEstacion ||
           coincidePalabra {

            resultados.append(lugar)
        }
    }


    guard !resultados.isEmpty else {

        print("\n No encontramos lugares relacionados.")
        print("Prueba con otra palabra.")

        return
    }


    print("\n======================================")
    print("          LUGARES ENCONTRADOS")
    print("======================================")


    for (indice, lugar)
        in resultados.enumerated() {

        print("\n\(indice + 1). \(lugar.nombre)")
        print("Estación recomendada: \(lugar.estacion)")
        print("Línea: Línea \(lugar.linea)")
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

    guard let enlace = buscarEnlace(
        entre: lineaOrigen,
        y: lineaDestino
    ) else {
        return nil
    }

    return estacionSalida(
        del: enlace,
        para: lineaOrigen
    )
}


// RF06 - Consultar una ruta entre dos estaciones
func obtenerRecorrido(
    desde origen: String,
    hasta destino: String,
    en linea: LineaMetro
) -> [String]? {

    guard let indiceOrigen =
        obtenerIndiceEstacion(origen, en: linea),

          let indiceDestino =
        obtenerIndiceEstacion(destino, en: linea)

    else {
        return nil
    }


    if indiceOrigen <= indiceDestino {

        return Array(
            linea.estaciones[indiceOrigen...indiceDestino]
        )

    } else {

        return Array(
            linea.estaciones[indiceDestino...indiceOrigen]
                .reversed()
        )
    }
}


func imprimirTramo(
    desde origen: String,
    hasta destino: String,
    lineaNumero: Int
) {

    guard let linea =
        buscarLinea(numero: lineaNumero),

          let recorrido =
        obtenerRecorrido(
            desde: origen,
            hasta: destino,
            en: linea
        )

    else {

        print("No se pudo calcular este tramo.")
        return
    }


    print("\nLÍNEA \(lineaNumero)")
    print("--------------------------------------")


    for (indice, estacion) in recorrido.enumerated() {

        if indice == 0 {

            print("INICIO  → \(estacion)")

        } else if indice == recorrido.count - 1 {

            print("LLEGADA → \(estacion)")

        } else {

            print("          \(estacion)")
        }
    }


    print("Estaciones del tramo: \(recorrido.count)")
}


func consultarRuta(
    origen: String,
    destino: String
) {

    guard let origenReal =
        obtenerNombreEstacion(origen)
    else {

        print("\n No se encontró la estación de origen.")
        return
    }


    guard let destinoReal =
        obtenerNombreEstacion(destino)
    else {

        print("\n No se encontró la estación de destino.")
        return
    }


    if normalizarTexto(origenReal) ==
        normalizarTexto(destinoReal) {

        print("\nOrigen y destino son la misma estación.")
        return
    }


    let lineasOrigen =
        obtenerLineasDeEstacion(origenReal)

    let lineasDestino =
        obtenerLineasDeEstacion(destinoReal)


    var mejorCamino: [Int]?

    var lineaInicialElegida: Int?

    var lineaFinalElegida: Int?


    // Busca el camino con menor cantidad de líneas
    for lineaOrigen in lineasOrigen {

        for lineaDestino in lineasDestino {

            if let camino =
                buscarCaminoDeLineas(
                    desde: lineaOrigen,
                    hasta: lineaDestino
                ) {

                if mejorCamino == nil ||
                   camino.count < mejorCamino!.count {

                    mejorCamino = camino
                    lineaInicialElegida = lineaOrigen
                    lineaFinalElegida = lineaDestino
                }
            }
        }
    }


    guard let camino = mejorCamino,
          let lineaInicial = lineaInicialElegida,
          let lineaFinal = lineaFinalElegida
    else {

        print("\n No se encontró una ruta posible.")
        return
    }


    print("\n======================================")
    print("            PLAN DE VIAJE")
    print("======================================")

    print("\nOrigen: \(origenReal)")
    print("Destino: \(destinoReal)")

    print(
        "Líneas: " +
        camino
            .map { "L\($0)" }
            .joined(separator: " → ")
    )


    // =================================================
    // MISMA LÍNEA
    // =================================================

    if lineaInicial == lineaFinal {

        imprimirTramo(
            desde: origenReal,
            hasta: destinoReal,
            lineaNumero: lineaInicial
        )

        print("\n Viaje directo.")
        print("No necesitas cambiar de línea.")

        return
    }


    // =================================================
    // VARIAS LÍNEAS
    // =================================================

    var estacionActual = origenReal

    var cantidadEnlaces = 0


    for indice in 0..<(camino.count - 1) {

        let lineaActual = camino[indice]

        let siguienteLinea = camino[indice + 1]


        guard let enlace =
            buscarEnlace(
                entre: lineaActual,
                y: siguienteLinea
            )
        else {

            print("\n Error al construir el recorrido.")
            return
        }


        let salida = estacionSalida(
            del: enlace,
            para: lineaActual
        )


        let entrada = estacionEntrada(
            del: enlace,
            hacia: siguienteLinea
        )


        imprimirTramo(
            desde: estacionActual,
            hasta: salida,
            lineaNumero: lineaActual
        )


        cantidadEnlaces += 1


        print("\n======================================")
        print("        CAMBIO POR CERCANÍA")
        print("======================================")

        print("\nBaja en:")
        print("\(salida) - Línea \(lineaActual)")

        print("\nDirígete hacia:")
        print("\(entrada) - Línea \(siguienteLinea)")

        print("\n\(enlace.indicacion)")

        if normalizarTexto(salida) !=
            normalizarTexto(entrada) {

            print("\nEste desplazamiento se realiza")
            print("fuera del recorrido ferroviario.")
        }


        estacionActual = entrada
    }


    // Último tramo
    imprimirTramo(
        desde: estacionActual,
        hasta: destinoReal,
        lineaNumero: lineaFinal
    )


    print("\n======================================")
    print("              RESUMEN")
    print("======================================")

    print("Origen: \(origenReal)")
    print("Destino: \(destinoReal)")

    print(
        "Líneas utilizadas: " +
        camino
            .map { "L\($0)" }
            .joined(separator: " → ")
    )

    print("Cantidad de líneas: \(camino.count)")
    print("Cambios por cercanía: \(cantidadEnlaces)")

    print("\n Ruta calculada correctamente.")
}



// Lee un texto y evita que el usuario deje la entrada vacía
func leerTextoNoVacio(mensaje: String) -> String {

    while true {

        print(mensaje, terminator: "")

        if let entrada = readLine() {

            let textoLimpio = entrada
                .trimmingCharacters(in: .whitespacesAndNewlines)

            if !textoLimpio.isEmpty {
                return textoLimpio
            }
        }

        print(" Debe ingresar un valor.")
    }
}


// Lee un número entero y valida la entrada
func leerNumero(mensaje: String) -> Int {

    while true {

        print(mensaje, terminator: "")

        if let entrada = readLine() {

            let textoLimpio = entrada
                .trimmingCharacters(in: .whitespacesAndNewlines)

            if let numero = Int(textoLimpio) {
                return numero
            }
        }

        print(" Ingrese un número válido.")
    }
}


// Pausa el programa antes de volver al menú
func pausar() {

    print("\n--------------------------------------")
    print("Presione ENTER para continuar.")

    _ = readLine()
}




// Muestra las opciones principales del sistema
func mostrarMenu() {

    print("\n======================================")
    print("            METRORUTA LIMA")
    print("======================================")
    print("1. Ver líneas del Metro")
    print("2. Consultar estaciones de una línea")
    print("3. Buscar una estación")
    print("4. Consultar estado de una línea")
    print("5. Ver conexiones entre líneas")
    print("6. Consultar ruta entre estaciones")
    print("7. Buscar referencia o lugar cercano")
    print("0. Salir")
    print("======================================")
}


// Controla la ejecución completa del programa
func ejecutarPrograma() {

    var programaActivo = true

    print("======================================")
    print("      BIENVENIDO A METRORUTA LIMA")
    print("======================================")
    print("Consulta información del Metro")
    print("de Lima y Callao desde terminal.")

    while programaActivo {

        mostrarMenu()

        let opcion = leerNumero(
            mensaje: "Seleccione una opción: "
        )

        switch opcion {

        
        case 1:

            mostrarLineas()
            pausar()


        
        case 2:

            let numeroLinea = leerNumero(
                mensaje: "\nIngrese el número de línea: "
            )

            mostrarEstacionesDeLinea(
                numero: numeroLinea
            )

            pausar()


        
        case 3:

            let nombreEstacion = leerTextoNoVacio(
                mensaje: "\nIngrese el nombre de la estación: "
            )

            buscarEstacion(
                nombre: nombreEstacion
            )

            pausar()


        
        case 4:

            let numeroLinea = leerNumero(
                mensaje: "\nIngrese el número de línea: "
            )

            consultarEstadoLinea(
                numero: numeroLinea
            )

            pausar()


        
        case 5:

            mostrarConexiones()

            pausar()


        
        case 6:

            print("\n======================================")
            print("           CONSULTAR RUTA")
            print("======================================")

            let origen = leerTextoNoVacio(
                mensaje: "Estación de origen: "
            )

            let destino = leerTextoNoVacio(
                mensaje: "Estación de destino: "
            )

            consultarRuta(
                origen: origen,
                destino: destino
            )

            pausar()


        
        case 7:

            let referencia = leerTextoNoVacio(
                mensaje: "\nIngrese un lugar o referencia: "
            )

            buscarReferencia(
                referencia
            )

            pausar()


        
        case 0:

            programaActivo = false

            print("\n======================================")
            print("Gracias por utilizar MetroRuta Lima 🚇")
            print("======================================\n")


        
        default:

            print("\n Opción no válida. Intente nuevamente.")

            pausar()
        }
    }
}



ejecutarPrograma()
