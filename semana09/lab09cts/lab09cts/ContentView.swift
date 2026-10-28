import SwiftUI
import Foundation

// iOS 16 o posterior. Toda la lógica está dentro de ContentView.
struct ContentView: View {
    @State private var noviembre = true
    @State private var sueldoTexto = ""
    @State private var gratificacionTexto = ""
    @State private var asignacionFamiliar = false
    @State private var semestreCompleto = true
    @State private var mesesIngresados = 5
    @State private var diasIngresados = 0
    @State private var otrosTexto = "0"
    @State private var resultado: Decimal?
    @State private var error = ""
    @State private var mostrarError = false
    @FocusState private var escribiendo: Bool

    private var meses: Int { semestreCompleto ? 6 : mesesIngresados }
    private var dias: Int { semestreCompleto ? 0 : diasIngresados }
    private var familiar: Decimal { asignacionFamiliar ? (noviembre ? 123 : 113) : 0 }
    private var mesSueldo: String { noviembre ? "octubre de 2026" : "abril de 2026" }
    private var mesGratificacion: String { noviembre ? "julio de 2026" : "diciembre de 2025" }
    private var periodo: String { noviembre ? "mayo a octubre de 2026" : "noviembre de 2025 a abril de 2026" }
    private var entradas: String {
        "\(noviembre)|\(sueldoTexto)|\(gratificacionTexto)|\(asignacionFamiliar)|\(semestreCompleto)|\(mesesIngresados)|\(diasIngresados)|\(otrosTexto)"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("¿Qué CTS quieres calcular?", selection: $noviembre) {
                        Text("Mayo 2026").tag(false)
                        Text("Noviembre 2026").tag(true)
                    }
                }
                Section {
                    campo("¿Cuál es tu sueldo mensual?", texto: $sueldoTexto)
                } footer: {
                    Text("Copia el sueldo básico de tu boleta de \(mesSueldo), antes de descuentos. No sumes aquí la asignación familiar.")
                }
                Section {
                    Toggle("¿Recibes asignación familiar?", isOn: $asignacionFamiliar)
                    if asignacionFamiliar {
                        Text("Sumaremos \(soles(familiar)) automáticamente.")
                    }
                } footer: {
                    Text("Busca el concepto ‘asignación familiar’ en esa boleta. Si no lo recibes, deja la opción apagada.")
                }
                Section {
                    campo("¿Cuánto recibiste de gratificación?", texto: $gratificacionTexto)
                } footer: {
                    Text("Busca ‘gratificación’ en tu boleta de \(mesGratificacion). Copia solo ese importe, sin el bono adicional de 9 % o 6,75 %. Si no recibiste gratificación, escribe 0. La app lo divide entre seis por ti.")
                }
                Section {
                    Toggle("¿Trabajaste todo ese período?", isOn: $semestreCompleto)
                    if !semestreCompleto {
                        Stepper("Meses completos: \(mesesIngresados)", value: $mesesIngresados, in: 0...5)
                        Stepper("Días adicionales: \(diasIngresados)", value: $diasIngresados, in: 0...29)
                        Text("Ejemplo: si trabajaste 4 meses y 10 días, elige 4 y 10. No sumes días que ya están dentro de esos meses.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                } header: {
                    Text("Período: \(periodo)")
                } footer: {
                    Text("Marca Sí si trabajaste los seis meses completos sin ausencias que reduzcan tu CTS. Si tienes dudas sobre el tiempo reconocido, consúltalo en tu trabajo.")
                }
                Section {
                    DisclosureGroup("¿Tienes otros pagos fijos cada mes?") {
                        campo("Importe mensual adicional", texto: $otrosTexto)
                        Text("Déjalo en 0 si solo recibes tu sueldo y asignación familiar. Agrega únicamente pagos fijos mensuales que formen parte de tu remuneración. Si tienes comisiones u horas extras, primero se necesita revisar sus reglas de promedio.")
                            .font(.footnote)
                    }
                }
                Section {
                    Button("Calcular mi CTS", action: calcular)
                        .frame(maxWidth: .infinity)
                }
                if let total = resultado {
                    Section("Tu CTS calculada") {
                        Text(soles(total))
                            .font(.largeTitle.bold())
                            .frame(maxWidth: .infinity)
                        DisclosureGroup("Ver cómo se calculó") {
                            let sueldo = monto(sueldoTexto) ?? 0
                            let gratificacion = monto(gratificacionTexto) ?? 0
                            let otros = monto(otrosTexto) ?? 0
                            let sexto = gratificacion / 6
                            let base = sueldo + familiar + otros + sexto
                            Text("1. Gratificación ÷ 6 = \(soles(sexto, decimales: 4))")
                            Text("2. Sueldo + asignación familiar + otros pagos + ese sexto = \(soles(base, decimales: 4))")
                            Text("3. Esa suma × \(meses) meses ÷ 12 = \(soles(base * Decimal(meses) / 12, decimales: 4))")
                            Text("4. Esa suma × \(dias) días ÷ 360 = \(soles(base * Decimal(dias) / 360, decimales: 4))")
                            Text("5. Sumamos los pasos 3 y 4 y redondeamos el total a dos decimales.")
                        }
                        .font(.subheadline)
                    }
                }
                Section {
                    DisclosureGroup("¿Para quién sirve este cálculo?") {
                        Text("Para trabajadores del régimen general privado con sueldo fijo, jornada promedio de al menos 4 horas al día y un mes de antigüedad cumplido. No calcula regímenes especiales, liquidaciones al dejar el trabajo ni períodos pendientes de semestres anteriores.")
                        Text("Reglas revisadas al 27/10/2026: D.S. 001-97-TR y Ley 25129. Asignación familiar de abril: S/ 113; de octubre: S/ 123, según la RMV aplicable (D.S. 006-2024-TR y D.S. 015-2026-TR).")
                    }
                    .font(.footnote)
                }
            }
            .navigationTitle("Mi CTS")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Listo") { escribiendo = false }
                }
            }
            .onChange(of: entradas) { _ in resultado = nil }
            .alert("Revisa este dato", isPresented: $mostrarError) {
                Button("Aceptar", role: .cancel) { }
            } message: { Text(error) }
        }
    }

    private func campo(_ pregunta: String, texto: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(pregunta)
            TextField("S/ 0.00", text: texto)
                .keyboardType(.decimalPad)
                .focused($escribiendo)
        }
    }

    private func monto(_ texto: String) -> Decimal? {
        let limpio = texto.trimmingCharacters(in: .whitespacesAndNewlines)
        guard limpio.range(of: #"^[0-9]+([.,][0-9]{1,2})?$"#,
                           options: .regularExpression) != nil,
              let valor = Decimal(string: limpio.replacingOccurrences(of: ",", with: "."),
                                  locale: Locale(identifier: "en_US_POSIX")),
              valor >= 0, valor <= 999_999_999 else { return nil }
        return valor
    }

    private func soles(_ valor: Decimal, decimales: Int = 2) -> String {
        let formato = NumberFormatter()
        formato.locale = Locale(identifier: "es_PE")
        formato.numberStyle = .currency
        formato.currencySymbol = "S/"
        formato.minimumFractionDigits = decimales
        formato.maximumFractionDigits = decimales
        return formato.string(from: NSDecimalNumber(decimal: valor)) ?? "S/ 0.00"
    }

    private func avisar(_ mensaje: String) {
        error = mensaje
        mostrarError = true
    }

    private func calcular() {
        escribiendo = false
        resultado = nil
        guard let sueldo = monto(sueldoTexto), sueldo > 0 else {
            avisar("Escribe tu sueldo mayor que cero, por ejemplo 3000 o 3000,50. No uses separadores de miles.")
            return
        }
        guard let gratificacion = monto(gratificacionTexto) else {
            avisar("Escribe la gratificación de \(mesGratificacion). Si no recibiste, escribe 0. Usa como máximo dos decimales.")
            return
        }
        guard let otros = monto(otrosTexto) else {
            avisar("Revisa el importe de otros pagos. Si no tienes, escribe 0.")
            return
        }
        guard meses * 30 + dias > 0, meses * 30 + dias <= 180 else {
            avisar("Selecciona los meses y días que trabajaste. El período debe ser mayor que cero y no superar seis meses.")
            return
        }
        let sexto = gratificacion / 6
        let base = sueldo + familiar + otros + sexto
        let porMeses = base * Decimal(meses) / 12
        let porDias = base * Decimal(dias) / 360
        var totalSinRedondear = porMeses + porDias
        var total = Decimal()
        NSDecimalRound(&total, &totalSinRedondear, 2, .plain)
        resultado = total
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View { ContentView() }
}
