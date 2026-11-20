import Foundation
import Combine   // Necesario en Xcode nuevo para ObservableObject y @Published

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var searchText: String = ""

    var filteredUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { user in
                user.name.lowercased().contains(searchText.lowercased())
            }
        }
    }

    // GET: Obtener todos los usuarios
    func fetchUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                if let decodedUsers = try? JSONDecoder().decode([User].self, from: data) {
                    DispatchQueue.main.async {
                        self.users = decodedUsers
                    }
                }
            }
        }.resume()
    }

    // POST: Crear un nuevo usuario
    func createUser(name: String, email: String) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let newUser = User(id: 0, name: name, email: email) // id lo ignora el servidor

        do {
            request.httpBody = try JSONEncoder().encode(newUser)
        } catch {
            print("Error al codificar el usuario")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let createdUser = try? JSONDecoder().decode(User.self, from: data) {
                    DispatchQueue.main.async {
                        self.users.append(createdUser)
                    }
                }
            }
        }.resume()
    }

    // TO DO → PUT: Actualizar un usuario existente
    func updateUser(user: User) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(user.id)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            print("Error al codificar el usuario")
            return
        }

        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                // Reemplaza el usuario en la lista local (la API es de prueba y no guarda cambios)
                if let index = self.users.firstIndex(where: { $0.id == user.id }) {
                    self.users[index] = user
                    print("Usuario actualizado localmente.")
                } else {
                    print("Usuario no encontrado para actualizar.")
                }
            }
        }.resume()
    }

    // DELETE: Eliminar un usuario por id
    func deleteUser(id: Int) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(id)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                self.users.removeAll { $0.id == id }
                print("Usuario eliminado localmente (simulado)")
            }
        }.resume()
    }
}
