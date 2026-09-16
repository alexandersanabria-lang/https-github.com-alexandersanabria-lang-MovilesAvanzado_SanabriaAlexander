import Foundation

// ===== ACTIVIDAD PROPUESTA 02 =====
// HERENCIA DE CLIENTES
// Estudiante: Alexander Sanabria

class Cliente {

    let codigo: String
    let direccion: String
    let fechaDeRegistro: String
    let numeroCuenta: String
    let montoMinimoApertura: Double

    init(
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double
    ) {

        self.codigo = codigo
        self.direccion = direccion
        self.fechaDeRegistro = fechaDeRegistro
        self.numeroCuenta = numeroCuenta
        self.montoMinimoApertura = montoMinimoApertura
    }

    func mostrarDatos() {

        print("Codigo: \(codigo)")
        print("Direccion: \(direccion)")
        print("Fecha de registro: \(fechaDeRegistro)")
        print("Numero de cuenta: \(numeroCuenta)")
        print("Monto minimo de apertura: S/ \(montoMinimoApertura)")
    }
}

class ClienteNatural: Cliente {

    let nombreCompleto: String
    let dni: String

    init(
        nombreCompleto: String,
        dni: String,
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double
    ) {

        self.nombreCompleto = nombreCompleto
        self.dni = dni

        super.init(
            codigo: codigo,
            direccion: direccion,
            fechaDeRegistro: fechaDeRegistro,
            numeroCuenta: numeroCuenta,
            montoMinimoApertura: montoMinimoApertura
        )
    }

    override func mostrarDatos() {

        print("CLIENTE NATURAL")
        print("Nombre: \(nombreCompleto)")
        print("DNI: \(dni)")

        super.mostrarDatos()
    }
}

class ClienteJuridico: Cliente {

    let razonSocial: String
    let ruc: String
    let representanteLegal: String

    init(
        razonSocial: String,
        ruc: String,
        representanteLegal: String,
        codigo: String,
        direccion: String,
        fechaDeRegistro: String,
        numeroCuenta: String,
        montoMinimoApertura: Double
    ) {

        self.razonSocial = razonSocial
        self.ruc = ruc
        self.representanteLegal = representanteLegal

        super.init(
            codigo: codigo,
            direccion: direccion,
            fechaDeRegistro: fechaDeRegistro,
            numeroCuenta: numeroCuenta,
            montoMinimoApertura: montoMinimoApertura
        )
    }

    override func mostrarDatos() {

        print("CLIENTE JURIDICO")
        print("Razon Social: \(razonSocial)")
        print("RUC: \(ruc)")
        print("Representante Legal: \(representanteLegal)")

        super.mostrarDatos()
    }
}

let clienteNatural = ClienteNatural(
    nombreCompleto: "Juan Perez",
    dni: "12345678",
    codigo: "C001",
    direccion: "Av. Lima 123",
    fechaDeRegistro: "2025-06-03",
    numeroCuenta: "001-2025-000123",
    montoMinimoApertura: 500.0
)

let clienteJuridico = ClienteJuridico(
    razonSocial: "Soluciones SAC",
    ruc: "20123456789",
    representanteLegal: "Maria Leon",
    codigo: "C002",
    direccion: "Jr. Empresas 456",
    fechaDeRegistro: "2025-06-01",
    numeroCuenta: "001-2025-000456",
    montoMinimoApertura: 3000.0
)

clienteNatural.mostrarDatos()

print("------------------------------")

clienteJuridico.mostrarDatos()
