//
//  MessagesView.swift
//  Lab14IntroFirebase
//  Versión mejorada: burbujas de chat
//

import SwiftUI
import FirebaseAuth

struct MessagesView: View {
    @StateObject private var databaseService = DatabaseService()
    @State private var newMessage = ""

    // Email del usuario conectado (para saber qué mensajes son míos)
    private var miEmail: String { Auth.auth().currentUser?.email ?? "" }

    var body: some View {
        VStack(spacing: 0) {
            // MARK: Header con avatar y Sign Out
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.blue.gradient)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(String(miEmail.prefix(1)).uppercased())
                            .font(.headline)
                            .foregroundColor(.white)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text("Chat Lab 14")
                        .font(.headline)
                    Text(miEmail)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }

                Spacer()

                Button {
                    try? Auth.auth().signOut()
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.title3)
                        .foregroundColor(.red)
                }
            }
            .padding()
            .background(.bar)

            Divider()

            // MARK: Lista de mensajes con scroll automático
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 10) {
                        if databaseService.messages.isEmpty {
                            VStack(spacing: 8) {
                                Image(systemName: "bubble.left.and.bubble.right")
                                    .font(.system(size: 44))
                                    .foregroundColor(.secondary)
                                Text("Aún no hay mensajes")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top, 80)
                        }

                        ForEach(databaseService.messages) { message in
                            BurbujaMensaje(message: message, esMio: message.userEmail == miEmail)
                                .id(message.id)
                        }
                    }
                    .padding()
                }
                .background(Color(.systemGroupedBackground))
                .onChange(of: databaseService.messages.count) {
                    // Baja al último mensaje cuando llega uno nuevo
                    if let ultimo = databaseService.messages.last {
                        withAnimation {
                            proxy.scrollTo(ultimo.id, anchor: .bottom)
                        }
                    }
                }
            }

            // MARK: Campo para escribir
            HStack(spacing: 10) {
                TextField("Escribe un mensaje...", text: $newMessage)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(Capsule())
                    .submitLabel(.send)
                    .onSubmit(enviar)

                Button(action: enviar) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 34))
                }
                .disabled(newMessage.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(.bar)
        }
        .onAppear {
            databaseService.startListening()
        }
    }

    // Envía el mensaje (botón o tecla "Enviar" del teclado)
    private func enviar() {
        let texto = newMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !texto.isEmpty else { return }
        databaseService.addMessage(text: texto)
        newMessage = ""
    }
}

// MARK: - Burbuja de un mensaje
struct BurbujaMensaje: View {
    let message: Message
    let esMio: Bool

    var body: some View {
        HStack {
            if esMio { Spacer(minLength: 50) }

            VStack(alignment: esMio ? .trailing : .leading, spacing: 4) {
                // El email solo se muestra en los mensajes de otros
                if !esMio {
                    Text(message.userEmail)
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }

                Text(message.text)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(esMio ? Color.blue : Color(.systemBackground))
                    .foregroundColor(esMio ? .white : .primary)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .shadow(color: .black.opacity(0.05), radius: 2, y: 1)

                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }

            if !esMio { Spacer(minLength: 50) }
        }
    }
}
