import Foundation

// Desarrollado por: Alexander Sanabria

// ===== TODO 1: Registro de 5 alumnos =====
var alumnos: [String] = []
for i in 1...5 {
    print("Nombre del alumno \(i):")
    let nombre = readLine() ?? ""
    alumnos.append(nombre)
}
print("Alumnos: \(alumnos)")

// ===== TODO 2: Buscar un alumno =====
print("Buscar alumno:")
let buscar = readLine() ?? ""
if alumnos.contains(buscar) {
    print("\(buscar) está en la lista")
} else {
    print("\(buscar) NO está en la lista")
}

// ===== TODO 3: Notas con clasificación =====
var notasClase: [Double] = []
for i in 1...5 {
    print("Nota del alumno \(i):")
    let n = Double(readLine() ?? "") ?? 0
    notasClase.append(n)
}

var aprobados = 0
var desaprobados = 0
var sumaNotas = 0.0
for nota in notasClase {
    sumaNotas += nota
    if nota >= 13 {
        aprobados += 1
    } else {
        desaprobados += 1
    }
}

print("Promedio: \(sumaNotas / Double(notasClase.count))")
print("Aprobados: \(aprobados), Desaprobados: \(desaprobados)")

// ===== FIX: 3 errores corregidos =====
var frutas = ["Manzana", "Plátano", "Naranja"]
frutas.append("Pera") // FIX 1: se agregó un String, no un Int

var colores = ["Rojo", "Azul", "Verde"] // FIX 2: cambiado de "let" a "var" para poder modificarlo
colores.append("Amarillo")

let numeros = [10, 20, 30, 40, 50]
print(numeros[4]) // FIX 3: índice válido (0 a 4), antes era numeros[5] que no existe

print("Frutas: \(frutas)")
print("Colores: \(colores)")

// ===== PREDICT =====
var lista = [1, 2, 3, 4, 5]
lista.remove(at: 0)
lista.append(6)
print(lista) // PREDICT 1: [2, 3, 4, 5, 6]
print(lista.count) // PREDICT 2: 5

var nombresP = ["Ana", "Carlos", "Beto"]
print(nombresP.sorted()) // PREDICT 3: ["Ana", "Beto", "Carlos"]
print(nombresP) // PREDICT 4: ["Ana", "Carlos", "Beto"] (sorted() no modifica el original)

// ===== TODO 4: Catálogo de productos =====
var productos: [String: Double] = [:]
for i in 1...4 {
    print("Producto \(i) - Nombre:")
    let nombre = readLine() ?? ""
    print("Precio:")
    let precio = Double(readLine() ?? "") ?? 0
    productos[nombre] = precio
}

// ===== TODO 5: Mostrar catálogo =====
print("===== CATÁLOGO =====")
for (nombre, precio) in productos {
    print("\(nombre): S/. \(precio)")
}

// ===== TODO 6: Valor total =====
var valorTotal = 0.0
for (_, precio) in productos {
    valorTotal += precio
}
print("Valor total: S/. \(valorTotal)")

// ===== TODO 7: Buscar producto =====
print("Buscar producto:")
let buscarProd = readLine() ?? ""
if let precioEncontrado = productos[buscarProd] {
    print("\(buscarProd) cuesta S/. \(precioEncontrado)")
} else {
    print("Producto no encontrado")
}

// ===== ANALYZE =====
var edades: [String: Int] = ["Ana": 20, "Luis": 22, "María": 19]
var mayores: [String] = []
for (nombre, edad) in edades {
    if edad >= 21 {
        mayores.append(nombre)
    }
}
print("Mayores de 21: \(mayores)")
// ANALYZE 1: Recorre el diccionario "edades" y guarda en "mayores" los nombres
// de las personas cuya edad es mayor o igual a 21. Imprime: Mayores de 21: ["Luis"]

// ===== TODO 8: Eliminar duplicados =====
var numerosDup: [Int] = []
for i in 1...8 {
    print("Número \(i):")
    let n = Int(readLine() ?? "") ?? 0
    numerosDup.append(n)
}
print("Con duplicados: \(numerosDup)")
let sinDuplicados = Array(Set(numerosDup)).sorted()
print("Sin duplicados: \(sinDuplicados)")

// ===== TODO 9: Comparar asistencia =====
var asistenciaLunes: Set<String> = []
print("===== ASISTENCIA LUNES =====")
for i in 1...4 {
    print("Alumno \(i):")
    let nombre = readLine() ?? ""
    asistenciaLunes.insert(nombre)
}

var asistenciaMartes: Set<String> = []
print("\n===== ASISTENCIA MARTES =====")
for i in 1...4 {
    print("Alumno \(i):")
    let nombre = readLine() ?? ""
    asistenciaMartes.insert(nombre)
}

let ambosDias = asistenciaLunes.intersection(asistenciaMartes)
let soloLunes = asistenciaLunes.subtracting(asistenciaMartes)
let soloMartes = asistenciaMartes.subtracting(asistenciaLunes)

print("\n===== RESULTADOS ASISTENCIA =====")
print("Ambos días: \(ambosDias)")
print("Solo lunes: \(soloLunes)")
print("Solo martes: \(soloMartes)")

// ===== PREDICT Sets =====
let a: Set = [1, 2, 3, 4, 5]
let b: Set = [4, 5, 6, 7, 8]
print(a.intersection(b)) // PREDICT 5: [4, 5]
print(a.union(b).count) // PREDICT 6: 8
print(a.subtracting(b)) // PREDICT 7: [1, 2, 3]

var repetidos: Set = ["A", "B", "A", "C", "B"]
print(repetidos.count) // PREDICT 8: 3 (Set elimina duplicados automáticamente)

// ===== TODO 10: Inventario de productos =====
var preciosInv: [String: Double] = [:]
var stocksInv: [String: Int] = [:]
print("¿Cuántos productos?")
let nInv = Int(readLine() ?? "") ?? 0
for i in 1...nInv {
    print("Producto \(i) - Nombre:")
    let nombre = readLine() ?? ""
    print("Precio:")
    let precio = Double(readLine() ?? "") ?? 0
    print("Stock:")
    let stock = Int(readLine() ?? "") ?? 0
    preciosInv[nombre] = precio
    stocksInv[nombre] = stock
}

// Calcular valor total (precio × stock)
var valorTotalInv = 0.0
for (nombre, precio) in preciosInv {
    if let stock = stocksInv[nombre] {
        valorTotalInv += precio * Double(stock)
    }
}
print("Valor total del inventario: S/. \(valorTotalInv)")

// Mostrar productos con stock < 5
print("\n===== PRODUCTOS CON STOCK BAJO (< 5) =====")
for (nombre, stock) in stocksInv {
    if stock < 5 {
        print("\(nombre): \(stock) unidades")
    }
}

// ===== CARRITO DE COMPRAS 2.0 =====
var nombresCarrito: [String] = []
var preciosCarrito: [Double] = []
var cantidadesCarrito: [Int] = []

// TODO 11: Pedir productos
print("¿Cuántos productos va a comprar?")
let totalProductos = Int(readLine() ?? "") ?? 0
for i in 1...totalProductos {
    print("\nProducto \(i) - Nombre:")
    nombresCarrito.append(readLine() ?? "")
    print("Precio unitario:")
    preciosCarrito.append(Double(readLine() ?? "") ?? 0)
    print("Cantidad:")
    cantidadesCarrito.append(Int(readLine() ?? "") ?? 0)
}

// TODO 12: Calcular subtotales
var subtotales: [Double] = []
for i in 0..<nombresCarrito.count {
    let sub = preciosCarrito[i] * Double(cantidadesCarrito[i])
    subtotales.append(sub)
}

// TODO 13: Total del carrito
var totalCarrito = 0.0
for sub in subtotales {
    totalCarrito += sub
}

// TODO 14: Nombre del cliente
print("\nNombre del cliente:")
let cliente = readLine() ?? ""

// TODO 15: Descuento
var descPct = 0.0
if totalCarrito >= 5000 { descPct = 0.15 }
else if totalCarrito >= 2000 { descPct = 0.10 }
else if totalCarrito >= 500 { descPct = 0.05 }
let descuento = totalCarrito * descPct
let totalConDesc = totalCarrito - descuento

// TODO 16: IGV y total
let igv = totalConDesc * 0.18
let totalFinal = totalConDesc + igv

// TODO 17: Categoria
var categoria = ""
switch Int(totalCarrito) {
case 0..<500: categoria = "Regular"
case 500..<2000: categoria = "Frecuente"
case 2000..<5000: categoria = "VIP"
default: categoria = "Premium"
}

// TODO 18: Ticket
let sep = String(repeating: "=", count: 45)
print(sep)
print(" TICKET DE COMPRA 2.0")
print(" Cliente: \(cliente) (\(categoria))")
print(sep)
for i in 0..<nombresCarrito.count {
    print("\(nombresCarrito[i]) x\(cantidadesCarrito[i]) S/. \(subtotales[i])")
}
print(sep)
print("Subtotal: S/. \(totalCarrito)")
if descPct > 0 {
    print("Descuento (\(descPct*100)%): -S/. \(descuento)")
}
print("IGV (18%): S/. \(igv)")
print(sep)
print("TOTAL: S/. \(totalFinal)")
print(sep)
print("¡Gracias por su compra, \(cliente)!")

// ===== EJERCICIO 6: Gestión de Notas (con IA) =====
// Desarrollado por: Alexander Sanabria

var notasAlumnos: [String: [Double]] = [:] // Diccionario: nombre del alumno -> array de sus 3 notas

print("¿Cuántos alumnos vas a registrar?") // Pregunta cuántos alumnos se van a ingresar
let cantAlumnosN6 = Int(readLine() ?? "") ?? 0 // Convierte la respuesta a Int, si falla usa 0

for i in 1...cantAlumnosN6 { // Repite una vez por cada alumno
    print("\nAlumno \(i) - Nombre:") // Pide el nombre del alumno actual
    let nombreN6 = readLine() ?? "" // Lee el nombre, si falla usa cadena vacía

    var notasIndividuales: [Double] = [] // Array temporal para las 3 notas de este alumno
    for j in 1...3 { // Repite 3 veces, una por cada nota
        print("Nota \(j) de \(nombreN6):") // Pide la nota j del alumno
        let notaN6 = Double(readLine() ?? "") ?? 0 // Convierte la entrada a Double, si falla usa 0
        notasIndividuales.append(notaN6) // Agrega la nota al array temporal
    }
    notasAlumnos[nombreN6] = notasIndividuales // Guarda el array de notas en el diccionario bajo el nombre del alumno
}

print("\n===== PROMEDIOS Y CLASIFICACIÓN =====") // Encabezado de la sección de resultados
var promedios: [String: Double] = [:] // Diccionario: nombre -> promedio, para usarlo después al ordenar

for (nombre, notas) in notasAlumnos { // Recorre cada alumno del diccionario
    let sumaN6 = notas.reduce(0, +) // Suma todas las notas del array usando reduce
    let promedioN6 = sumaN6 / Double(notas.count) // Calcula el promedio dividiendo entre la cantidad de notas
    promedios[nombre] = promedioN6 // Guarda el promedio calculado en el diccionario de promedios

    var clasificacion = "" // Variable donde se guardará el texto de clasificación
    switch promedioN6 { // Evalúa el promedio para clasificarlo
    case 17...20: clasificacion = "Excelente" // De 17 a 20 es Excelente
    case 14..<17: clasificacion = "Bueno" // De 14 a menos de 17 es Bueno
    case 13..<14: clasificacion = "Aprobado" // De 13 a menos de 14 es Aprobado
    default: clasificacion = "Desaprobado" // Cualquier otro caso (menor a 13) es Desaprobado
    }
    print("\(nombre): Promedio \(promedioN6) → \(clasificacion)") // Muestra el resultado de este alumno
}

// ===== ESTADÍSTICAS GENERALES =====
let todosLosPromedios = Array(promedios.values) // Convierte los valores del diccionario de promedios en un array
let promedioGeneral = todosLosPromedios.reduce(0, +) / Double(todosLosPromedios.count) // Promedio de todos los promedios
let notaMasAlta = todosLosPromedios.max() ?? 0 // Encuentra el promedio más alto, si no hay usa 0
let notaMasBaja = todosLosPromedios.min() ?? 0 // Encuentra el promedio más bajo, si no hay usa 0
let cantidadAprobados = todosLosPromedios.filter { $0 >= 13 }.count // Cuenta cuántos promedios son >= 13 (aprobados)
let porcentajeAprobados = (Double(cantidadAprobados) / Double(todosLosPromedios.count)) * 100 // Calcula el % de aprobados

print("\n===== ESTADÍSTICAS GENERALES =====") // Encabezado de estadísticas
print("Promedio general: \(promedioGeneral)") // Muestra el promedio general del salón
print("Nota más alta: \(notaMasAlta)") // Muestra la nota (promedio) más alta
print("Nota más baja: \(notaMasBaja)") // Muestra la nota (promedio) más baja
print("Porcentaje de aprobados: \(porcentajeAprobados)%") // Muestra el porcentaje de aprobados

// ===== ORDENAR POR PROMEDIO =====
let ordenadosPorPromedio = promedios.sorted { $0.value > $1.value } // Ordena el diccionario de mayor a menor promedio
print("\n===== RANKING (mayor a menor) =====") // Encabezado del ranking
for (nombre, promedio) in ordenadosPorPromedio { // Recorre la lista ya ordenada
    print("\(nombre): \(promedio)") // Muestra cada alumno con su promedio, en orden
}

// ===== EJERCICIO 7: Inventario con menú (con IA) =====
// Desarrollado por: Alexander Sanabria

var preciosN7: [String: Double] = [:] // Diccionario: nombre del producto -> precio
var stocksN7: [String: Int] = [:] // Diccionario: nombre del producto -> stock

print("¿Cuántos productos vas a registrar?") // Pregunta cuántos productos se cargarán al inicio
let cantProductosN7 = Int(readLine() ?? "") ?? 0 // Convierte la respuesta a Int, si falla usa 0

for i in 1...cantProductosN7 { // Repite una vez por cada producto a registrar
    print("\nProducto \(i) - Nombre:") // Pide el nombre del producto
    let nombreN7 = readLine() ?? "" // Lee el nombre, si falla usa cadena vacía
    print("Precio:") // Pide el precio del producto
    let precioN7 = Double(readLine() ?? "") ?? 0 // Convierte el precio a Double, si falla usa 0
    print("Stock:") // Pide el stock del producto
    let stockN7 = Int(readLine() ?? "") ?? 0 // Convierte el stock a Int, si falla usa 0
    preciosN7[nombreN7] = precioN7 // Guarda el precio en el diccionario de precios
    stocksN7[nombreN7] = stockN7 // Guarda el stock en el diccionario de stocks
}

var continuarMenu = true // Bandera que controla si el menú sigue mostrándose
while continuarMenu { // Se repite mientras la bandera sea true
    print("\n===== MENÚ INVENTARIO =====") // Encabezado del menú
    print("1) Ver inventario") // Opción 1
    print("2) Buscar producto") // Opción 2
    print("3) Productos con stock bajo") // Opción 3
    print("4) Valor total del inventario") // Opción 4
    print("5) Salir") // Opción 5
    print("Elige una opción:") // Pide al usuario que elija
    let opcionN7 = readLine() ?? "" // Lee la opción elegida como texto

    switch opcionN7 { // Evalúa qué opción fue elegida
    case "1": // Caso: ver inventario completo
        print("\n===== INVENTARIO =====") // Encabezado del reporte
        for (nombre, precio) in preciosN7 { // Recorre todos los productos
            let stock = stocksN7[nombre] ?? 0 // Obtiene el stock de ese producto, si no existe usa 0
            print("\(nombre): S/. \(precio) - Stock: \(stock)") // Muestra nombre, precio y stock
        }
    case "2": // Caso: buscar un producto puntual
        print("Nombre del producto a buscar:") // Pide el nombre a buscar
        let buscarN7 = readLine() ?? "" // Lee el nombre ingresado
        if let precioEncontrado = preciosN7[buscarN7] { // Busca el precio de forma segura con Optional
            let stockEncontrado = stocksN7[buscarN7] ?? 0 // Obtiene el stock correspondiente
            print("\(buscarN7): S/. \(precioEncontrado) - Stock: \(stockEncontrado)") // Muestra el resultado
        } else {
            print("Producto no encontrado") // Mensaje si no existe el producto
        }
    case "3": // Caso: mostrar productos con stock bajo
        print("\n===== STOCK BAJO (< 5) =====") // Encabezado del reporte
        for (nombre, stock) in stocksN7 { // Recorre todos los stocks
            if stock < 5 { // Filtra los que tienen menos de 5 unidades
                print("\(nombre): \(stock) unidades") // Muestra el producto con stock bajo
            }
        }
    case "4": // Caso: calcular el valor total del inventario
        var valorTotalN7 = 0.0 // Acumulador del valor total
        for (nombre, precio) in preciosN7 { // Recorre cada producto
            let stock = stocksN7[nombre] ?? 0 // Obtiene su stock
            valorTotalN7 += precio * Double(stock) // Suma precio × stock al acumulador
        }
        print("Valor total del inventario: S/. \(valorTotalN7)") // Muestra el resultado
    case "5": // Caso: salir del menú
        print("Saliendo del inventario...") // Mensaje de despedida
        continuarMenu = false // Cambia la bandera a false para terminar el while
    default: // Cualquier otra opción no contemplada
        print("Opción inválida, intenta de nuevo") // Mensaje de error
    }
}
