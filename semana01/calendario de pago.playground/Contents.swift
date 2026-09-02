import Foundation

// ===== CALENDARIO DE PAGOS =====
// Ingresa nombre, precio unitario y cantidad del producto,
// y calcula el monto total de la compra

// Tasas de interés según el plan de pago elegido (ajustar si el profesor dio otras)
let tasaInteres6Meses = 0.08   // 8%
let tasaInteres12Meses = 0.15  // 15%
let tasaInteres24Meses = 0.25  // 25%

print("Ingrese el nombre del producto")
let producto = readLine() ?? ""

print("Ingrese el precio unitario del producto")
let precioUnitario = Double(readLine() ?? "0") ?? 0.0

print("Ingrese la cantidad del producto")
let cantidad = Int(readLine() ?? "0") ?? 0

let montoTotalCompra = precioUnitario * Double(cantidad)

print("--------------------------------------")
print("Producto: \(producto)")
print("Monto total de la compra: S/. \(montoTotalCompra)")
print("--------------------------------------")

// ===== SELECCIÓN DE PLAN DE PAGO =====
print("Elija el plan de pago en meses: 6, 12 o 24")
let plazoMeses = Int(readLine() ?? "0") ?? 0

var tasaInteres = 0.0

//hallar la tasa segun el plan elegido
if plazoMeses == 6 {
    tasaInteres = tasaInteres6Meses
} else if plazoMeses == 12 {
    tasaInteres = tasaInteres12Meses
} else if plazoMeses == 24 {
    tasaInteres = tasaInteres24Meses
} else {
    print("Plan no válido, se asignará 6 meses por defecto")
    tasaInteres = tasaInteres6Meses
}

//hallar el monto final con interes y la cuota mensual
let montoFinal = montoTotalCompra * (1 + tasaInteres)
let cuotaMensual = montoFinal / Double(plazoMeses)

print("--------------------------------------")
print("====== PLAN DE PAGO ======")
print("Producto: \(producto)")
print("Monto de compra: S/. \(montoTotalCompra)")
print("Interés: \(tasaInteres * 100)%")
print("Monto final: S/. \(montoFinal)")
print("Cuota por mes: S/. \(cuotaMensual)")
print("--------------------------------------")
