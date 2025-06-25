import SwiftUI

struct SignupView: View {
    @Environment(\.dismiss) var dismiss

    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)

            TextField("Email", text: $email)
                .padding().background(Color(.systemGray6)).cornerRadius(8).keyboardType(.emailAddress).autocapitalization(.none)

            SecureField("Password", text: $password)
                .padding().background(Color(.systemGray6)).cornerRadius(8).textContentType(.newPassword)

            SecureField("Confirm Password", text: $confirmPassword)
                .padding().background(Color(.systemGray6)).cornerRadius(8).textContentType(.newPassword)

            Button(action: {
                print("Sign Up tapped. Email: \(email)")
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
    }
}

#Preview {
    SignupView()
}
