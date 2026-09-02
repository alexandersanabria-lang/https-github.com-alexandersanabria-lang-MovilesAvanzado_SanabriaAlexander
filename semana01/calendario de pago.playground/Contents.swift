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
