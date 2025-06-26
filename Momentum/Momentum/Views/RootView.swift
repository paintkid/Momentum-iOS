import SwiftUI

struct RootView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        if authViewModel.session == nil {
            LoginView()
        } else {
            HomeView()
        }
    }
}

#Preview {
    RootView()
        .environmentObject(AuthViewModel())
}
