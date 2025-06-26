import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    @State private var rooms: [Room] = []

    var body: some View {
        NavigationStack {
            List(rooms) { room in
                Text(room.name)
            }
            .navigationTitle("Your Rooms")
            .toolbar {
                Button("Logout") {
                    Task {
                        try? await authViewModel.signOut()
                    }
                }
            }
            .onAppear {
                Task {
                    await fetchRooms()
                }
            }
        }
    }

    private func fetchRooms() async {
        do {
            let fetchedRooms: [Room] = try await SupabaseManager.shared.client
                .from("rooms")
                .select()
                .execute()
                .value

            self.rooms = fetchedRooms

        } catch {
            print("Error fetching rooms: \(error.localizedDescription)")
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthViewModel())
}
