import SwiftUI

struct SignupView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)

            TextField("Username", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .keyboardType(.default)
                .autocapitalization(.none)
                .autocorrectionDisabled(true)

            TextField("Email", text: $email)
                .padding().background(Color(.systemGray6)).cornerRadius(8).keyboardType(.emailAddress).autocapitalization(.none)

            SecureField("Password", text: $password)
                .padding().background(Color(.systemGray6)).cornerRadius(8)

            SecureField("Confirm Password", text: $confirmPassword)
                .padding().background(Color(.systemGray6)).cornerRadius(8)

            Button(action: {
                Task {
                    await handleSignup()
                }
            }) {
                Text("Sign Up")
                    .font(.headline).foregroundColor(.white).padding().frame(maxWidth: .infinity).background(Color.blue).cornerRadius(8)
            }
            
            Button("Already have an account? Login") {
                dismiss()
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .alert(alertTitle, isPresented: $isShowingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func handleSignup() async {
        guard password == confirmPassword else {
            presentAlert(title: "Error", message: "Passwords do not match.")
            return
        }
        
        struct ProfileUpdate: Encodable {
            let username: String
        }
        
        do {
            let session = try await SupabaseManager.shared.client.auth.signUp(
                email: email,
                password: password
            )
            

            let profileUpdate = ProfileUpdate(username: self.username)
            try await SupabaseManager.shared.client.from("profiles")
                .update(profileUpdate)
                .eq("id", value: session.user.id)
                .execute()
            
            presentAlert(title: "Success", message: "Your account has been created! You can now log in.")
            
        } catch {
            presentAlert(title: "Signup Error", message: error.localizedDescription)
        }
    }
    
    private func presentAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        isShowingAlert = true
    }
}

#Preview {
    NavigationStack {
        SignupView()
    }
}
