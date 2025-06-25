import Foundation
import Supabase
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var session: Session?

    private var authListener: AuthStateChangeListenerRegistration?

    init() {
        Task {
            await listenToAuthState()
        }
    }
    
    func listenToAuthState() async {
        authListener = await SupabaseManager.shared.client.auth.onAuthStateChange { (event, session) in
            DispatchQueue.main.async {
                switch event {
                    case .signedIn, .tokenRefreshed:
                        self.session = session
                    case .signedOut:
                        self.session = nil
                    default:
                        break
                }
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
