//
//  ViewController.swift
//  CalculadoraPrestamos
//
//  Created by Alexander on 16/09/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtCapital: UITextField!
    @IBOutlet weak var txtTasa: UITextField!
    @IBOutlet weak var txtPlazo: UITextField!
    @IBOutlet weak var blCuotaMensual: UILabel!
    @IBOutlet weak var lblMontoTotal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        blCuotaMensual.text = "Cuota mensual: -"
        lblMontoTotal.text = "Monto total a pagar: -"
            }

    @IBAction func calcularPrestamo(_ sender: Any) {
                // Obtener los valores ingresados
                let capital = Double(txtCapital.text ?? "") ?? 0
                let tasaAnual = Double(txtTasa.text ?? "") ?? 0
                let plazoAnios = Double(txtPlazo.text ?? "") ?? 0

                // Validar que los valores sean correctos
                if capital <= 0 || tasaAnual <= 0 || plazoAnios <= 0 {
                    blCuotaMensual.text = "Por favor, ingresa valores válidos."
                    lblMontoTotal.text = ""
                    return
                }

                // r: tasa de interés mensual (tasa anual entre 12, en decimal)
                let r = (tasaAnual / 100) / 12
                // n: número total de pagos (años * 12)
                let n = plazoAnios * 12

                // Fórmula de la cuota mensual: M = P * r(1+r)^n / ((1+r)^n - 1)
                let factor = pow(1 + r, n)
                let cuotaMensual = capital * (r * factor) / (factor - 1)

                // Monto total a pagar = cuota mensual * número de pagos
                let montoTotal = cuotaMensual * n

                // Mostrar resultados
                blCuotaMensual.text = "Cuota mensual: $\(String(format: "%.2f", cuotaMensual))"
                lblMontoTotal.text = "Monto total a pagar: $\(String(format: "%.2f", montoTotal))"
    }


}

