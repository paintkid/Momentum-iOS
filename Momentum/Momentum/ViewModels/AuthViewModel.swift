import Foundation
import Supabase

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var session: Session?

    private var authListener: AuthStateChangeListenerRegistration?

    init() {
        Task {
            await loadInitialSession()
            await listenToAuthStateChanges()
        }
    }
    
    private func loadInitialSession() async {
        do {
            let currentSession = try await SupabaseManager.shared.client.auth.session
            self.session = currentSession
            print("AuthViewModel: Found an existing session for user \(currentSession.user.id)")
        } catch {
            print("AuthViewModel: No existing session found on app launch.")
        }
    }

    private func listenToAuthStateChanges() async {
        authListener = await SupabaseManager.shared.client.auth.onAuthStateChange { (event, session) in
            DispatchQueue.main.async {
                self.session = session
            }
        }
    }
    
    func signIn(email: String, password: String) async throws {
        try await SupabaseManager.shared.client.auth.signIn(email: email, password: password)
    }
    
    func signUp(email: String, password: String) async throws {
        try await SupabaseManager.shared.client.auth.signUp(email: email, password: password)
    }
    
    func signOut() async throws {
        try await SupabaseManager.shared.client.auth.signOut()
    }
}
