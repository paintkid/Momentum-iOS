// In Views/HomeView.swift
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var rooms: [Room] = []
    @State private var isShowingCreateRoomSheet = false

    var body: some View {
        NavigationStack {
            List(rooms) { room in
                Text(room.name)
            }
            .navigationTitle("Your Rooms")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingCreateRoomSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                    
                    Button("Logout") {
                        Task { try? await authViewModel.signOut() }
                    }
                }
            }
            .onAppear {
                Task { await fetchRooms() }
            }
            .sheet(isPresented: $isShowingCreateRoomSheet) {
                Task { await fetchRooms() }
            } content: {
                CreateRoomView()
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
