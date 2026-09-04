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
