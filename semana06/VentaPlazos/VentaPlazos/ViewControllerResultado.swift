//
//  ViewControllerResultado.swift
//  VentaPlazos
//
//  Created by Alexander on 1/10/26.
//

import UIKit

class ViewControllerResultado: UIViewController {
    
    var venta: VentaModel?

    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblIgv: UILabel!
    @IBOutlet weak var lblBase: UILabel!
    @IBOutlet weak var lblIntereses: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblCuota: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let venta = venta {

                    lblSubtotal.text =
                        String(format: "S/. %.2f", venta.subtotal)

                    lblIgv.text =
                        String(format: "S/. %.2f", venta.igv)

                    lblBase.text =
                        String(format: "S/. %.2f", venta.base)

                    lblIntereses.text =
                        String(format: "S/. %.2f", venta.intereses)

                    lblTotal.text =
                        String(format: "S/. %.2f", venta.total)

                    lblCuota.text =
                        String(format: "S/. %.2f", venta.cuota)
                }
            }
        }
