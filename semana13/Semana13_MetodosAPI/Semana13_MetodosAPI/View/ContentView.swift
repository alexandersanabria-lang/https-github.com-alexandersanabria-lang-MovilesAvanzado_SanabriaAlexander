import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    @State private var showingForm = false
    @State private var editingUser: User? = nil

    var body: some View {
        NavigationView {
            VStack {
                TextField("Buscar usuario por nombre", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List(viewModel.filteredUsers) { user in
                    VStack(alignment: .leading) {
                        Text(user.name).font(.headline)
                        Text(user.email).font(.subheadline).foregroundColor(.gray)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deleteUser(id: user.id)
                        } label: {
                            Label("Eliminar", systemImage: "trash")
                        }

                        Button {
                            editingUser = user
                            showingForm = true
                        } label: {
                            Label("Editar", systemImage: "pencil")
                        }.tint(.blue)
                    }
                }

                Button("➕ Agregar Usuario") {
                    editingUser = nil
                    showingForm = true
                }
                .padding()
            }
            .navigationTitle("Usuarios")
            .onAppear {
                viewModel.fetchUsers()
            }
            .sheet(isPresented: $showingForm) {
                if let user = editingUser {
                    UserFormView(name: user.name, email: user.email, isEditing: true) { name, email in
                        let updated = User(id: user.id, name: name, email: email)
                        viewModel.updateUser(user: updated)
                    }
                } else {
                    UserFormView(name: "", email: "", isEditing: false) { name, email in
                        viewModel.createUser(name: name, email: email)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
