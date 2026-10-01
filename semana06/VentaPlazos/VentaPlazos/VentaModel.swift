import UIKit

class VentaModel: NSObject {

    var subtotal: Double
    var igv: Double
    var base: Double
    var intereses: Double
    var total: Double
    var cuota: Double

    init(
        subtotal: Double,
        igv: Double,
        base: Double,
        intereses: Double,
        total: Double,
        cuota: Double
    ) {
        self.subtotal = subtotal
        self.igv = igv
        self.base = base
        self.intereses = intereses
        self.total = total
        self.cuota = cuota
    }
}
