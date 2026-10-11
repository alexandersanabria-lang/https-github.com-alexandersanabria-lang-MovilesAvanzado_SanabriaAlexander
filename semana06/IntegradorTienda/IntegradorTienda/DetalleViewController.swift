import UIKit

class DetalleViewController: UIViewController {

    var producto: Producto!
    var carrito: CarritoModel!
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblStock: UILabel!
    @IBOutlet weak var lblCantidad: UILabel!
    
    var cantidad = 1
    
    @IBAction func cantidadChanged(_ sender: UIStepper) {
        cantidad = Int(sender.value)
        lblCantidad.text = "\(cantidad)"
    
    }

    @IBAction func agregarAlCarritoTapped(_ sender: UIButton) {
        
        let agregado = carrito.agregar(
            producto: producto,
            cantidad: cantidad
        )
        
        if agregado {
            navigationController?.popViewController(animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNombre.text = producto.nombre
        lblPrecio.text = String(format: "S/ %.2f", producto.precio)
        lblStock.text = "\(producto.stock)"
        lblCantidad.text = "\(cantidad)"
    }
}
