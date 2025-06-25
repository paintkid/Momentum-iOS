import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    @State private var email = ""
    @State private var password = ""

    @State private var isShowingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Momentum").font(.largeTitle).fontWeight(.bold).padding(.bottom, 40)
                TextField("Email", text: $email).padding().background(Color(.systemGray6)).cornerRadius(8).keyboardType(.emailAddress).autocapitalization(.none).autocorrectionDisabled(true)
                SecureField("Password", text: $password).padding().background(Color(.systemGray6)).cornerRadius(8)

                Button(action: {
                    Task {
                        await handleLogin()
                    }
                }) {
                    Text("Login").font(.headline).foregroundColor(.white).padding().frame(maxWidth: .infinity).background(Color.blue).cornerRadius(8)
                }

                NavigationLink("Don't have an account? Sign Up") { SignupView() }.padding(.top)

                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .alert("Login Error", isPresented: $isShowingAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }

    private func handleLogin() async {
        do {
            try await authViewModel.signIn(email: email, password: password)
        } catch {
            self.alertMessage = error.localizedDescription
            self.isShowingAlert = true
        }
    }
}
