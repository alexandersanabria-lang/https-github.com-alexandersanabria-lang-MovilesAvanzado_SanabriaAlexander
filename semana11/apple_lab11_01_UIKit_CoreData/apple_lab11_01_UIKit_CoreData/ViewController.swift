import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlet conectado al UITableView del storyboard
    @IBOutlet weak var TablaContacto: UITableView!

    // Arreglo que almacena los contactos obtenidos desde Core Data
    var contactos = [Contacto]()

    // Método llamado al cargar la vista
    override func viewDidLoad() {
        super.viewDidLoad()
        TablaContacto.dataSource = self
        TablaContacto.delegate = self
        mostrarRutaBaseDeDatos()
        cargarInfoCoreData()   // Carga los datos almacenados en Core Data
    }

    // MARK: - Conexión con Core Data

    // Obtiene el contexto de Core Data para realizar operaciones de lectura y escritura
    func conexion() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }

    // Imprime en consola dónde está el archivo SQLite de la app
    func mostrarRutaBaseDeDatos() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let ruta = delegate.persistentContainer.persistentStoreDescriptions.first?.url?.path ?? "sin ruta"
        print("Base de datos SQLite en: \(ruta)")
    }

    // MARK: - READ: leer los datos

    // Carga los contactos almacenados y actualiza el arreglo local
    func cargarInfoCoreData() {
        let contexto = conexion()
        let fetchRequest: NSFetchRequest<Contacto> = Contacto.fetchRequest()
        // Orden alfabético por nombre
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        do {
            contactos = try contexto.fetch(fetchRequest)
        } catch {
            print("Error al cargar la BD: \(error)")
        }
    }

    // MARK: - UITableViewDataSource

    // Número de filas en la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactos.count
    }

    // Configura cada celda de la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = TablaContacto.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        celda.textLabel?.text = contactos[indexPath.row].nombre
        celda.detailTextLabel?.text = "\(contactos[indexPath.row].telefono ?? "") | \(contactos[indexPath.row].direccion ?? "")"
        return celda
    }

    // MARK: - CREATE: agregar un contacto

    // Acción vinculada al Bar Button Item (+)
    @IBAction func agregarContacto(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Agregar Contacto", message: "Nuevo Contacto", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Nombre" }
        alert.addTextField { $0.placeholder = "Telefono" }
        alert.addTextField { $0.placeholder = "Direccion" }

        let actionAceptar = UIAlertAction(title: "Aceptar", style: .default) { _ in
            guard let nombre = alert.textFields?[0].text, !nombre.isEmpty else { return }
            let telefono = alert.textFields?[1].text ?? ""
            let direccion = alert.textFields?[2].text ?? ""

            let contexto = self.conexion()
            // Crea un nuevo objeto Contacto en el contexto (todavía NO está guardado)
            let entidad = NSEntityDescription.insertNewObject(forEntityName: "Contacto", into: contexto) as! Contacto
            entidad.nombre = nombre
            entidad.telefono = telefono
            entidad.direccion = direccion

            do {
                try contexto.save()          // Aquí se escribe en el archivo SQLite
                self.cargarInfoCoreData()    // Vuelve a leer los datos
                self.TablaContacto.reloadData()
            } catch {
                print("Error al guardar el dato: \(error)")
            }
        }
        alert.addAction(actionAceptar)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }

    // MARK: - UPDATE: editar un contacto (al tocar una fila)

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contacto = contactos[indexPath.row]

        let alert = UIAlertController(title: "Editar Contacto", message: "Modifica los datos", preferredStyle: .alert)
        alert.addTextField { $0.text = contacto.nombre }
        alert.addTextField { $0.text = contacto.telefono }
        alert.addTextField { $0.text = contacto.direccion }

        let actionGuardar = UIAlertAction(title: "Guardar", style: .default) { _ in
            guard let nombre = alert.textFields?[0].text, !nombre.isEmpty else { return }
            // Cambiar las propiedades del objeto y guardar el contexto
            contacto.nombre = nombre
            contacto.telefono = alert.textFields?[1].text
            contacto.direccion = alert.textFields?[2].text
            do {
                try self.conexion().save()
                self.cargarInfoCoreData()
                self.TablaContacto.reloadData()
            } catch {
                print("Error al actualizar: \(error)")
            }
        }
        alert.addAction(actionGuardar)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }

    // MARK: - DELETE: eliminar un contacto

    // Elimina un contacto específico dado el índice en la tabla
    func eliminarContacto(at indexPath: IndexPath) {
        let contexto = conexion()
        let contactoEliminar = contactos[indexPath.row]
        contexto.delete(contactoEliminar)        // Marca el objeto para borrarlo
        do {
            try contexto.save()                  // Confirma el borrado en SQLite
            contactos.remove(at: indexPath.row)  // Lo quita del arreglo local
            TablaContacto.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Error al eliminar: \(error)")
        }
    }

    // Permite eliminar deslizando la fila hacia la izquierda
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            eliminarContacto(at: indexPath)
        }
    }
}
