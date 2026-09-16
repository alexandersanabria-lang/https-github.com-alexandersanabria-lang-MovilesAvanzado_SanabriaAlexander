import Foundation

// ===== CASO 1.5: HERENCIA Y POLIMORFISMO — LA CADENA DE SUCURSALES =====
// Docente: Juan León


// =====================================================
// ENUM Y STRUCT
// =====================================================

enum CategoriaElectro {
    case lineaBlanca
    case tecnologia
    case pequenos
}


struct Electrodomestico {
    let nombre: String
    let marca: String
    let precioLista: Double
    let categoria: CategoriaElectro
}


// =====================================================
// CLASE BASE
// =====================================================

class Sucursal {

    let nombre: String
    let ciudad: String

    init(nombre: String, ciudad: String) {
        self.nombre = nombre
        self.ciudad = ciudad
    }

    func descuento() -> Double {
        return 0.05
    }

    func costoEnvio(monto: Double) -> Double {
        return 30.0
    }

    // Este método define el flujo de la cotización.
    // No debe sobreescribirse en las subclases.
    func cotizar(item: Electrodomestico) {

        let precioConDescuento =
            item.precioLista * (1 - descuento())

        let envio =
            costoEnvio(monto: precioConDescuento)

        let total =
            precioConDescuento + envio

        print(
            "\(nombre): \(item.nombre) -> " +
            "S/ \(precioConDescuento) + " +
            "envio S/ \(envio) = S/ \(total)"
        )
    }
}


// =====================================================
// TODO 14: SUCURSAL LIMA
// =====================================================

class SucursalLima: Sucursal {

    override func descuento() -> Double {
        return 0.10
    }

    override func costoEnvio(monto: Double) -> Double {

        if monto >= 1500 {
            return 0.0
        } else {
            return 30.0
        }
    }
}


// =====================================================
// TODO 15: SUCURSAL PROVINCIA
// =====================================================

class SucursalProvincia: Sucursal {

    // No se sobreescribe descuento().
    // Hereda el 5 % de la clase Sucursal.

    override func costoEnvio(monto: Double) -> Double {

        let envio = monto * 0.08

        if envio < 50.0 {
            return 50.0
        } else {
            return envio
        }
    }
}


// =====================================================
// TODO 16: SUCURSAL OUTLET
// =====================================================

class SucursalOutlet: Sucursal {

    override func descuento() -> Double {
        return 0.25
    }

    override func costoEnvio(monto: Double) -> Double {
        return 0.0
    }
}


// =====================================================
// TODO 18: SUCURSAL ONLINE
// =====================================================

class SucursalOnline: Sucursal {
    override func costoEnvio(monto: Double) -> Double { return 15.0 }
}

// Para agregar SucursalOnline se necesitaron 4 líneas nuevas:
// 3 líneas para declarar la nueva subclase y
// 1 línea para agregar la instancia al array.
// No fue necesario modificar cotizar(item:) ni los for-in.


// =====================================================
// TODO 17: PRODUCTOS
// =====================================================

let refrigeradora = Electrodomestico(
    nombre: "Refrigeradora",
    marca: "Frost",
    precioLista: 2000.0,
    categoria: .lineaBlanca
)


let licuadora = Electrodomestico(
    nombre: "Licuadora",
    marca: "Mix",
    precioLista: 250.0,
    categoria: .pequenos
)


// =====================================================
// TODO 17 Y 18: ARRAY POLIMÓRFICO
// =====================================================

let sucursales: [Sucursal] = [

    SucursalLima(
        nombre: "Lima Centro",
        ciudad: "Lima"
    ),

    SucursalProvincia(
        nombre: "Provincia Cusco",
        ciudad: "Cusco"
    ),

    SucursalOutlet(
        nombre: "Outlet Ate",
        ciudad: "Lima"
    ),

    SucursalOnline(nombre: "Tienda Online", ciudad: "Virtual")
]


// =====================================================
// RECORRIDO POLIMÓRFICO
// =====================================================

print("===== Refrigeradora (S/ 2000.0) =====")

for sucursal in sucursales {
    sucursal.cotizar(item: refrigeradora)
}


print("===== Licuadora (S/ 250.0) =====")

for sucursal in sucursales {
    sucursal.cotizar(item: licuadora)
}


// =====================================================
// FIX 7
// =====================================================

class SucursalMall: Sucursal {

    // FIX 7:
    // Swift exige override porque descuento()
    // ya está definido en la clase padre Sucursal.

    override func descuento() -> Double {
        return 0.12
    }
}


// =====================================================
// FIX 8
// =====================================================

class SucursalExpress: Sucursal {

    let radioKm: Int

    init(
        nombre: String,
        ciudad: String,
        radioKm: Int
    ) {

        self.radioKm = radioKm

        // FIX 8:
        // Falta llamar al inicializador
        // de la clase padre Sucursal.

        super.init(
            nombre: nombre,
            ciudad: ciudad
        )
    }
}


// =====================================================
// PREDICT 6 Y 7
// =====================================================

let misteriosa: Sucursal =
    SucursalLima(
        nombre: "Lima Centro",
        ciudad: "Lima"
    )


// PREDICT 6:
// Imprime 0.1.
// Aunque misteriosa está declarada como Sucursal,
// el objeto real es SucursalLima.
// Por polimorfismo se ejecuta descuento()
// de SucursalLima.

print(misteriosa.descuento())


let monto =
    2000.0 * (1 - misteriosa.descuento())


// PREDICT 7:
// monto vale 1800.0.
// SucursalLima devuelve envío 0.0
// porque el monto es mayor o igual a 1500.

print(misteriosa.costoEnvio(monto: monto))
