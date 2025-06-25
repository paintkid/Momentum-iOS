import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
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

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .textContentType(.newPassword)

            Button(action: {
                print("Login tapped. Email: \(email)")
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }

            Text("Don't have an account? Sign Up")
                .padding(.top)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
