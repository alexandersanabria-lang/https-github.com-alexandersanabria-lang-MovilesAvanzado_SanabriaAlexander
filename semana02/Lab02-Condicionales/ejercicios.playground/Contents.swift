import UIKit

// ===== EJERCICIO 1: CONDICIONALES =====

// --- Ejemplo (ya resuelto): ---
let nota = 15.0
if nota >= 13.0 {
    print("Aprobado con \(nota)")
} else {
    print("Desaprobado con \(nota)")
}
// --- TODO 1: Validar si una persona es mayor de edad ---
let edad = 17
if edad >= 18 {
    print("Es mayor de edad")
} else {
    print("Es menor de edad")
}
// --- TODO 2: Clasificar una nota con else if ---
let miNota = 16.0
// Categorías: Excelente (18-20), Bueno (15-17), Aprobado (13-14), Desaprobado (0-12)
if miNota >= 18 {
    print("Excelente")
} else if miNota >= 15 {
    print("Bueno")
} else if miNota >= 13 {
    print("Aprobado")
} else {
    print("Desaprobado")
}
// --- TODO 3: Verificar si un número es positivo, negativo o cero ---
let numero = -5
if numero > 0 {
    print("Positivo")
} else if numero < 0 {
    print("Negativo")
} else {
    print("Cero")
}
// ===== FIX: Encuentra y corrige los 3 errores =====
let temperatura = 35
if temperatura > 30 {
    print("Hace calor")
} else if temperatura > 20 {
    print("Clima agradable")
} else {
    print("Hace frío")
}
let saldo = 100.0
let compra = 150.0
if saldo >= compra {
    print("Compra realizada")
} else {
    print("Saldo insuficiente: te faltan \(compra - saldo)")
}
let hora = 25
if hora >= 0 && hora < 12 {
    print("Buenos días")
} else if hora >= 12 && hora < 18 {
    print("Buenas tardes")
} else if hora >= 18 && hora <= 23 {
    print("Buenas noches")
} else {
    print("Hora inválida")
}
// PREDICT: ¿Qué imprime cada bloque?
let x = 10
if x > 5 && x < 20 {
    print("Dentro del rango")
} else {
    print("Fuera del rango")
} // PREDICT 1: ___

let y = 15
if y > 20 {
    print("Mayor que 20")
} else if y > 10 {
    print("Mayor que 10")
} else if y > 5 {
    print("Mayor que 5")
} // PREDICT 2: ___

let esLunes = true
let llueve = false
if esLunes && llueve {
    print("Lunes lluvioso")
} else if esLunes || llueve {
    print("Es lunes O llueve")
} else {
    print("Ni lunes ni llueve")
} // PREDICT 3: ___


// --- TODO 4: Clasificar nota numérica a letra ---
let nota2 = 16
switch nota2 {
case 18...20: print("Excelente")
case 15...17: print("Bueno")
case 13...14: print("Aprobado")
case 11...12: print("Desaprobado")
case 0...10: print("Desaprobado")
default: print("Nota inválida")
}

// --- TODO 5: Calculadora simple con switch ---
let num1 = 20.0
let num2 = 5.0
let operacion = "+"
switch operacion {
case "+": print("Resultado: \(num1 + num2)")
case "-": print("Resultado: \(num1 - num2)")
case "*": print("Resultado: \(num1 * num2)")
case "/":
    if num2 != 0 {
        print("Resultado: \(num1 / num2)")
    } else {
        print("Error: no se puede dividir entre cero")
    }
default: print("Operación no válida")
}

// --- TODO 6: Categoría de producto por precio ---
let precio = 350.0
let precioEntero = Int(precio)
var categoriaProducto = ""
switch precioEntero {
case 0..<100: categoriaProducto = "Económico"
case 100..<500: categoriaProducto = "Medio"
case 500..<1000: categoriaProducto = "Premium"
default: categoriaProducto = "Lujo"
}
print("Categoría del producto: \(categoriaProducto)")

// PREDICT: ¿Qué imprime?
let mes = 2
switch mes {
case 1, 3, 5, 7, 8, 10, 12: print("31 días")
case 4, 6, 9, 11: print("30 días")
case 2: print("28 o 29 días")
default: print("Mes inválido")
} // PREDICT 4: "28 o 29 días"

let letra: Character = "a"
switch letra {
case "a", "e", "i", "o", "u": print("Vocal")
default: print("Consonante")
} // PREDICT 5: "Vocal"



// ===== EJERCICIO 3: FOR-IN =====

for i in 1...5 {
    print("Número: \(i)")
}

// --- TODO 7: Tabla del 7 ---
for i in 1...12 {
    print("7 x \(i) = \(7 * i)")
}

// --- TODO 8: Sumatoria del 1 al 100 ---
var suma = 0
for i in 1...100 {
    suma = suma + i
}
print("La suma del 1 al 100 es: \(suma)") // 5050

// --- TODO 9: Factorial de 8 ---
var factorial = 1
for i in 1...8 {
    factorial = factorial * i
}
print("8! = \(factorial)") // 40320

// --- TODO 10: Patrón de asteriscos ---
for i in 1...5 {
    print(String(repeating: "*", count: i))
}

// FIX 4: pares del 2 al 20
for i in 1...20 {
    if i % 2 == 0 {
        print(i)
    }
}

// FIX 5: cuenta regresiva del 10 al 1
for i in stride(from: 10, through: 1, by: -1) {
    print(i)
}

// PREDICT 6
var total = 0
for i in 1...5 {
    total += i
}
print(total) // Valor: 15, Iteraciones: 5

// PREDICT 7
var texto = ""
for _ in 1...3 {
    texto += "Hola "
}
print(texto) // "Hola Hola Hola "
// El "_" se usa cuando no necesitas el valor del índice, solo repetir la acción

// ===== EJERCICIO 4: WHILE =====

var contador = 5
while contador > 0 {
    print("Cuenta regresiva: \(contador)")
    contador -= 1
}
print("¡Despegue!")

// --- TODO 11: Ahorro mensual ---
var ahorro = 0.0
var meses = 0
let meta = 2000.0
let ahorroMensual = 150.0
while ahorro < meta {
    ahorro += ahorroMensual
    meses += 1
}
print("Necesita \(meses) meses para juntar S/. \(meta)")

// --- TODO 12: División sucesiva ---
var numero2 = 1000.0
var divisiones = 0
while numero2 >= 1 {
    numero2 = numero2 / 2
    divisiones += 1
    print("División \(divisiones): \(numero2)")
}
print("Se dividió \(divisiones) veces")

// --- TODO 13: repeat-while ---
let intento1 = 25
let intento2 = -3
let intento3 = 15

var intentoActual = intento1
var esValido = false
var numIntento = 1

repeat {
    if intentoActual >= 0 && intentoActual <= 20 {
        esValido = true
        print("Nota \(intentoActual) válida en intento \(numIntento)")
    } else {
        print("Nota \(intentoActual) inválida, intento \(numIntento)")
        if numIntento == 1 { intentoActual = intento2 }
        if numIntento == 2 { intentoActual = intento3 }
        numIntento += 1
    }
} while !esValido

// PREDICT 8
var a = 100
while a > 1 {
    a = a / 3
}
print(a) // Valor final: 1, Vueltas: 4 (100→33→11→3→1)

// PREDICT 9
var b = 0
repeat {
    b += 1
} while b < 0
print(b) // Valor: 1
// repeat-while ejecuta al menos una vez porque revisa la condición AL FINAL, no al inicio
