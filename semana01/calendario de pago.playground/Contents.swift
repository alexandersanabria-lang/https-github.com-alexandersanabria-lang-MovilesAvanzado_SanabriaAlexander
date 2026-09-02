import Foundation

// ===== CALENDARIO DE PAGOS (VERSIÓN CON IA) =====
// Ingresa nombre, precio unitario y cantidad del producto,
// y calcula el monto total de la compra

// Tasas de interés según el plan de pago elegido (ajustar si el profesor dio otras)
let tasaInteres6Meses = 0.08   // 8%
let tasaInteres12Meses = 0.15  // 15%
let tasaInteres24Meses = 0.25  // 25%

// funcion para redondear montos a 2 decimales
func redondear(_ valor: Double) -> Double {
    return (valor * 100).rounded() / 100
}

// ===== FECHA Y HORA =====
let formateadorFecha = DateFormatter()
formateadorFecha.dateFormat = "dd/MM/yyyy HH:mm:ss"
let fechaHoraActual = formateadorFecha.string(from: Date())

print("Ingrese el nombre del producto")
let producto = readLine() ?? ""

// validar que el precio unitario sea mayor a 0
var precioUnitario = 0.0
repeat {
    print("Ingrese el precio unitario del producto")
    precioUnitario = Double(readLine() ?? "0") ?? 0.0
    if precioUnitario <= 0 {
        print("El precio debe ser mayor a 0, intente de nuevo")
    }
} while precioUnitario <= 0

// validar que la cantidad sea mayor a 0
var cantidad = 0
repeat {
    print("Ingrese la cantidad del producto")
    cantidad = Int(readLine() ?? "0") ?? 0
    if cantidad <= 0 {
        print("La cantidad debe ser mayor a 0, intente de nuevo")
    }
} while cantidad <= 0

let montoTotalCompra = redondear(precioUnitario * Double(cantidad))

print("--------------------------------------")
print("Producto: \(producto)")
print("Monto total de la compra: S/. \(montoTotalCompra)")
print("--------------------------------------")

// ===== SELECCIÓN DE PLAN DE PAGO =====
var plazoMeses = 0
repeat {
    print("Elija el plan de pago en meses: 6, 12 o 24")
    plazoMeses = Int(readLine() ?? "0") ?? 0
    if plazoMeses != 6 && plazoMeses != 12 && plazoMeses != 24 {
        print("Plan no válido, ingrese 6, 12 o 24")
    }
} while plazoMeses != 6 && plazoMeses != 12 && plazoMeses != 24

var tasaInteres = 0.0

//hallar la tasa segun el plan elegido
if plazoMeses == 6 {
    tasaInteres = tasaInteres6Meses
} else if plazoMeses == 12 {
    tasaInteres = tasaInteres12Meses
} else {
    tasaInteres = tasaInteres24Meses
}

//hallar el monto final con interes y la cuota mensual
let montoFinal = redondear(montoTotalCompra * (1 + tasaInteres))
let cuotaMensual = redondear(montoFinal / Double(plazoMeses))

print("--------------------------------------")
print("====== PLAN DE PAGO ======")
print("Fecha y hora: \(fechaHoraActual)")
print("Producto: \(producto)")
print("Monto de compra: S/. \(montoTotalCompra)")
print("Interés: \(tasaInteres * 100)%")
print("Monto final: S/. \(montoFinal)")
print("Cuota por mes: S/. \(cuotaMensual)")
print("--------------------------------------")

// ===== PAGO ADELANTADO =====
var mesPagoAdelantado = -1
repeat {
    print("¿En qué mes hará un pago adelantado? (0 = ninguno, máximo \(plazoMeses))")
    mesPagoAdelantado = Int(readLine() ?? "-1") ?? -1
    if mesPagoAdelantado < 0 || mesPagoAdelantado > plazoMeses {
        print("Mes no válido, ingrese un número entre 0 y \(plazoMeses)")
    }
} while mesPagoAdelantado < 0 || mesPagoAdelantado > plazoMeses

var montoAdicional = 0.0
if mesPagoAdelantado > 0 {
    repeat {
        print("Ingrese el monto adicional a pagar en el mes \(mesPagoAdelantado)")
        montoAdicional = Double(readLine() ?? "0") ?? -1
        if montoAdicional <= 0 {
            print("El monto adicional debe ser mayor a 0, intente de nuevo")
        }
    } while montoAdicional <= 0
}

// ===== CUADRO MES A MES =====
print("====== DETALLE DE PAGOS ======")
print("Mes\tMonto Inicial\tCuota Mensual\tResta por Pago")

var saldoRestante = montoFinal

//recorrer cada mes del plazo elegido
for mes in 1...plazoMeses {
    let montoInicial = saldoRestante
    var restaPorPago = redondear(saldoRestante - cuotaMensual)
    if mes == plazoMeses {
        restaPorPago = 0.0
    }
    print("\(mes)\tS/. \(montoInicial)\tS/. \(cuotaMensual)\tS/. \(restaPorPago)")
    saldoRestante = restaPorPago
}
print("--------------------------------------")
