import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var listaProfesores = [
        Profesor(nombre: "Jaime Gomez", cargo: "Coordinador de Software", foto: UIImage(named: "avatar1")!),
        Profesor(nombre: "Jaime Farfan", cargo: "Docente de Software TC", foto: UIImage(named: "avatar2")!),
        Profesor(nombre: "Juan León", cargo: "Docente de Software TC", foto: UIImage(named: "avatar3")!),
        Profesor(nombre: "Silvia Montoya", cargo: "Docente de Software TC", foto: UIImage(named: "avatar4")!),
        Profesor(nombre: "Theobaldo Diaz", cargo: "Docente de Software TC", foto: UIImage(named: "avatar5")!),
        Profesor(nombre: "Elliot Garamendi", cargo: "Docente de Software TC", foto: UIImage(named: "avatar6")!),
        Profesor(nombre: "Edwin Huerto", cargo: "Docente de Redes TC", foto: UIImage(named: "avatar7")!)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaProfesores.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "miCell",
            for: indexPath
        ) as! PersonasTableViewCell

        let profesor = listaProfesores[indexPath.row]

        cell.personaNombre.text = profesor.nombre
        cell.PersonaImage.image = profesor.foto

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let profesor = listaProfesores[indexPath.row]

        let alerta = UIAlertController(
            title: "Profesor seleccionado",
            message: "\(profesor.nombre)\n\(profesor.cargo)",
            preferredStyle: .alert
        )

        alerta.addAction(UIAlertAction(title: "OK", style: .cancel))

        self.present(alerta, animated: true)
    }
}
