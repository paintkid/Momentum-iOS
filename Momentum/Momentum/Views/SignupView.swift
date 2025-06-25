import SwiftUI

struct SignupView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss

    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    @State private var isShowingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account").font(.largeTitle).fontWeight(.bold).padding(.bottom, 40)
            TextField("Email", text: $email).padding().background(Color(.systemGray6)).cornerRadius(8).keyboardType(.emailAddress).autocapitalization(.none).autocorrectionDisabled(true)
            SecureField("Password", text: $password).padding().background(Color(.systemGray6)).cornerRadius(8).textContentType(.newPassword)
            SecureField("Confirm Password", text: $confirmPassword).padding().background(Color(.systemGray6)).cornerRadius(8).textContentType(.newPassword)

            Button(action: {
                Task {
                    await handleSignup()
                }
            }) {
                Text("Sign Up").font(.headline).foregroundColor(.white).padding().frame(maxWidth: .infinity).background(Color.blue).cornerRadius(8)
            }

            Button("Already have an account? Login") { dismiss() }.padding(.top)

            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .alert("Signup Info", isPresented: $isShowingAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }

    private func handleSignup() async {
        guard password == confirmPassword else {
            self.alertMessage = "Passwords do not match."
            self.isShowingAlert = true
            return
        }

        do {
            try await authViewModel.signUp(email: email, password: password)
            self.alertMessage = "Sign up successful! If you disabled email confirmation, you will be logged in automatically."
            self.isShowingAlert = true
        } catch {
            self.alertMessage = error.localizedDescription
            self.isShowingAlert = true
        }
    }
}
