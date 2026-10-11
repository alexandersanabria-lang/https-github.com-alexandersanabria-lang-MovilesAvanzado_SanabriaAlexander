import UIKit

class DatosClienteViewController: UIViewController {
    
    var carrito: CarritoModel!

    @IBOutlet weak var tfApellidos: UITextField!
    @IBOutlet weak var tfNombres: UITextField!
    @IBOutlet weak var tfDNI: UITextField!
    
    @IBAction func confirmarCompraTapped(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "verBoleta" {

            let destino = segue.destination as! BoletaViewController

            let cliente = ClienteModel(
                apellido: tfApellidos.text ?? "",
                nombre: tfNombres.text ?? "",
                dni: tfDNI.text ?? ""
            )

            destino.cliente = cliente
            destino.carrito = carrito
        }
    }
}
