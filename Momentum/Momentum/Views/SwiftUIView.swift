import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome!")
                .font(.largeTitle)

            if let email = authViewModel.session?.user.email {
                Text("You are logged in as: \(email)")
            }

            Button("Logout") {
                Task {
                    do {
                        try await authViewModel.signOut()
                    } catch {
                        print("Error signing out: \(error.localizedDescription)")
                    }
                }
            }
            .tint(.red)
            .buttonStyle(.bordered)
        }
    }
}
