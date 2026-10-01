//
//  ViewController.swift
//  VentaPlazos
//
//  Created by Alexander on 1/10/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfElectrodomestico: UITextField!
    @IBOutlet weak var tfPrecio: UITextField!
    @IBOutlet weak var tfCantidad: UITextField!
    @IBOutlet weak var tfMeses: UITextField!
    @IBOutlet weak var tfInteres: UITextField!
    
    var ventaCalculada: VentaModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnCalcular(_ sender: Any) {
        let precio = Double(tfPrecio.text ?? "") ?? 0
                let cantidad = Double(tfCantidad.text ?? "") ?? 0
                let meses = Double(tfMeses.text ?? "") ?? 0
                let tasaInteres = Double(tfInteres.text ?? "") ?? 0

                let subtotal = precio * cantidad
                let igv = subtotal * 0.18
                let base = subtotal + igv
                let intereses = base * (tasaInteres / 100) * meses
                let total = base + intereses
                let cuota = total / meses

                ventaCalculada = VentaModel(
                    subtotal: subtotal,
                    igv: igv,
                    base: base,
                    intereses: intereses,
                    total: total,
                    cuota: cuota
                )

                
            }

            override func prepare(
                for segue: UIStoryboardSegue,
                sender: Any?
            ) {

                if segue.identifier == "showResultado" {

                    let destino =
                        segue.destination as! ViewControllerResultado

                    destino.venta = ventaCalculada
                }
            }
        }
