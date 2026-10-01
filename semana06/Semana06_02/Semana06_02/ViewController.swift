//
//  ViewController.swift
//  Semana06_02
//
//  Created by Alexander on 30/09/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfApellido: UITextField!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfDni: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnContinuar(_ sender: Any) {
        let oCliente = ClienteModel(
                    pCodigo: 0,
                    pApellido: self.tfApellido.text ?? "",
                    pNombre: self.tfNombre.text ?? "",
                    pDni: self.tfDni.text ?? ""
                )

                // 2. Instanciar la segunda pantalla desde el Storyboard
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let oPantalla2 = storyboard.instantiateViewController(
                    withIdentifier: "ViewControllerConfirmacion"
                ) as! ViewControllerConfirmacion

                // 3. Pasar el objeto
                oPantalla2.pCliente = oCliente

                // 4. Presentar modalmente
                self.present(oPantalla2, animated: true, completion: nil)
    }
    
}

