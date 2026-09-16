//
//  ViewController.swift
//  laboratorio05_1
//
//  Created by Alexander on 16/09/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weightTextFiled: UITextField!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        resultLabel.text = "Introduce tu Peso y Altura"
    }

    @IBAction func CalcularResultado(_ sender: Any) {
                // Obtener los valores de peso y altura
                let weight = Double(weightTextFiled.text ?? "") ?? 0
                let height = Double(heightTextField.text ?? "") ?? 0

                // Verificar si los valores de entrada son válidos
                if weight == 0 || height == 0 {
                    resultLabel.text = "Por favor, ingresa valores válidos."
                    return
                }

                // Calcular el IMC
                let bmi = weight / (height * height)

                // Determinar el estado según el IMC
                var status = ""
                if bmi < 18.5 {
                    status = "Bajo peso"
                } else if bmi < 24.9 {
                    status = "Peso normal"
                } else if bmi < 29.9 {
                    status = "Sobrepeso"
                } else {
                    status = "Obesidad"
                }

                // Mostrar el resultado
                resultLabel.text = "IMC: \(String(format: "%.2f", bmi)) - \(status)"
    }
    
}

