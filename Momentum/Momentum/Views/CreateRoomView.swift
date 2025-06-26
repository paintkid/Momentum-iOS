import SwiftUI

struct CreateRoomView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss

    @State private var roomName = ""
    @State private var roomGoal = ""

    @State private var isShowingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Room Details")) {
                    TextField("Room Name", text: $roomName)
                    TextField("Goal (e.g., Workout 5x a week)", text: $roomGoal)
                }

                Section {
                    Button("Create Room") {
                        Task {
                            await handleCreateRoom()
                        }
                    }
                }
            }
            .navigationTitle("New Room")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Create Room", isPresented: $isShowingAlert) {
                Button("OK", role: .cancel) {
                    if !alertMessage.contains("Error") {
                        dismiss()
                    }
                }
            } message: {
                Text(alertMessage)
            }
        }
    }

    private func handleCreateRoom() async {
        guard let userId = authViewModel.session?.user.id else {
            self.alertMessage = "Error: Could not find user."
            self.isShowingAlert = true
            return
        }

        struct NewRoom: Encodable {
            let name: String
            let goal: String?
            let created_by: UUID
        }

        let newRoom = NewRoom(name: roomName, goal: roomGoal.isEmpty ? nil : roomGoal, created_by: userId)

        do {
            try await SupabaseManager.shared.client
                .from("rooms")
                .insert(newRoom)
                .execute()

            dismiss()

        } catch {
            self.alertMessage = "Error: \(error.localizedDescription)"
            self.isShowingAlert = true
        }
    }
}

#Preview {
    CreateRoomView()
        .environmentObject(AuthViewModel())
}
