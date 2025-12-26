import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var email = ""
    @State private var password = ""

    private var isEmailValid: Bool {
        let pattern = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        return email.range(of: pattern, options: [.regularExpression, .caseInsensitive]) != nil
    }
    private var isPasswordValid: Bool {
        return password.count >= 8
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Σύνδεση")
                    .font(.title.bold())
                Spacer()
                Button { dismiss() } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
            }

            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)

            SecureField("Κωδικός", text: $password)
                .textFieldStyle(.roundedBorder)

            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red).font(.footnote)
            }

            Button {
                Task { await viewModel.signIn(email: email, password: password) }
            } label: {
                Text(viewModel.isLoading ? "..." : "Σύνδεση")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(viewModel.isLoading || !isEmailValid || !isPasswordValid)
            .opacity((viewModel.isLoading || !isEmailValid || !isPasswordValid) ? 0.6 : 1)

            Spacer()
        }
        .padding()
        .onChange(of: viewModel.currentUser?.id) { _, newValue in
            if newValue != nil { dismiss() }
        }
    }
}
#Preview {
    LoginView()
}
