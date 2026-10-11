import UIKit

class CarritoViewController: UIViewController {

    var carrito: CarritoModel!

    @IBOutlet weak var lblProducto1: UILabel!
    @IBOutlet weak var lblPrecio1: UILabel!
    @IBOutlet weak var lblProducto2: UILabel!
    @IBOutlet weak var lblPrecio2: UILabel!

    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblDescuento: UILabel!
    @IBOutlet weak var lblIGV: UILabel!
    @IBOutlet weak var lblTotal: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        lblProducto1.text = ""
        lblPrecio1.text = ""
        lblProducto2.text = ""
        lblPrecio2.text = ""

        if carrito.items.count > 0 {
            let item = carrito.items[0]

            lblProducto1.text =
                "\(item.producto.nombre) x\(item.cantidad)"

            lblPrecio1.text =
                String(format: "%.2f", item.subtotal())
        }

        if carrito.items.count > 1 {
            let item = carrito.items[1]

            lblProducto2.text =
                "\(item.producto.nombre) x\(item.cantidad)"

            lblPrecio2.text =
                String(format: "%.2f", item.subtotal())
        }


        let subtotal = carrito.subtotal()
        let porcentaje = carrito.porcentajeDescuento()
        let descuento = subtotal * porcentaje
        let base = subtotal - descuento
        let igv = base * 0.18
        let total = base + igv

        lblSubtotal.text = String(format: "%.2f", subtotal)
        lblDescuento.text = String(format: "-%.2f", descuento)
        lblIGV.text = String(format: "%.2f", igv)
        lblTotal.text = String(format: "%.2f", total)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if segue.identifier == "verDatosCliente" {

                let destino = segue.destination as! DatosClienteViewController

                destino.carrito = carrito
            }
        }
}
