import SwiftUI

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""
    
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Momentum")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)

                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                Button(action: {
                    Task {
                        await handleLogin()
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                NavigationLink("Don't have an account? Sign Up") {
                    SignupView()
                }
                .padding(.top)

                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .alert(alertTitle, isPresented: $isShowingAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func handleLogin() async {
        do {
            try await SupabaseManager.shared.client.auth.signIn(
                email: email,
                password: password
            )
            presentAlert(title: "Success", message: "Logged in successfully!")
            
        } catch {
            presentAlert(title: "Login Error", message: error.localizedDescription)
        }
    }
    
    private func presentAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        isShowingAlert = true
    }
}

#Preview {
    LoginView()
}
