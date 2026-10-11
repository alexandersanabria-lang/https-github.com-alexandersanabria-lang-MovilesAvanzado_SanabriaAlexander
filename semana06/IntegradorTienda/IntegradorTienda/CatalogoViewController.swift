//
//  CatalogoViewController.swift
//  IntegradorTienda
//
//  Created by Alexander on 7/10/26.
//

import UIKit

class CatalogoViewController: UIViewController {
    
    let productos: [Producto] = [
            Producto(nombre: "Refrigeradora", precio: 2000, stock: 5),
            Producto(nombre: "Licuadora", precio: 250, stock: 10),
            Producto(nombre: "Laptop", precio: 3500, stock: 3),
            Producto(nombre: "Cocina", precio: 1200, stock: 4)
        ]
    let carrito = CarritoModel()
    
    @IBOutlet weak var btnVerCarrito: UIButton!

    @IBAction func productoTapped(_ sender: UIButton) {
        performSegue(
                    withIdentifier: "verDetalle",
                    sender: sender
                )
    }
    
    @IBAction func verCarritoTapped(_ sender: UIButton) {
        performSegue(
            withIdentifier: "verCarrito",
            sender: sender
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        btnVerCarrito.setTitle(
            "Ver carrito (\(carrito.cantidadTotal()))",
            for: .normal
        )
    }
    override func prepare(
            for segue: UIStoryboardSegue,
            sender: Any?
    ) {
        
        if segue.identifier == "verDetalle" {
            
            let boton = sender as! UIButton
            
            let destino =
            segue.destination as! DetalleViewController
            
            destino.producto = productos[boton.tag]
            destino.carrito = carrito
        }
        if segue.identifier == "verCarrito" {
            
            let destino =
            segue.destination as! CarritoViewController
            
            destino.carrito = carrito
        }
    }

}
