//
//  MessagesView.swift
//  Lab14IntroFirebase
//

import SwiftUI
import FirebaseAuth

struct MessagesView: View {
    @StateObject private var databaseService = DatabaseService()
    @State private var newMessage = ""

    var body: some View {
        VStack {
            // Header
            HStack {
                Text("Messages")
                    .font(.title)
                    .fontWeight(.bold)

                Spacer()

                Button("Sign Out") {
                    try? Auth.auth().signOut()
                }
                .foregroundColor(.red)
            }
            .padding()

            // Messages list
            List(databaseService.messages) { message in
                VStack(alignment: .leading, spacing: 5) {
                    Text(message.text)
                        .font(.body)

                    HStack {
                        Text(message.userEmail)
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Spacer()

                        Text(message.timestamp, style: .time)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 2)
            }

            // New message input
            HStack {
                TextField("Type a message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Send") {
                    if !newMessage.isEmpty {
                        databaseService.addMessage(text: newMessage)
                        newMessage = ""
                    }
                }
                .disabled(newMessage.isEmpty)
            }
            .padding()
        }
        .onAppear {
            databaseService.startListening()
        }
    }
}
