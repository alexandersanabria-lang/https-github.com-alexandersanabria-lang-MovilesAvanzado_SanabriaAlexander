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
