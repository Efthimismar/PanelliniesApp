import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = AuthViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var selectedDirection: Direction = .science
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16){
                Text("Δημιουργία λογαριασμού")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
            }
            TextField("Όνομα", text: $name)
                .textFieldStyle(.roundedBorder)

            Picker("Κατεύθυνση", selection: $selectedDirection) {
                ForEach(Direction.allCases) { direction in
                    Text(direction.localizedName).tag(direction)
                }
            }
            .pickerStyle(.menu) 
            .frame(maxWidth: .infinity)
            .tint(.accentColor)
            
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Κωδικός", text: $password)
                .textFieldStyle(.roundedBorder)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            Button {
                Task {
                    await viewModel.signUp(
                        name: name,
                        direction: selectedDirection,
                        email: email,
                        password: password
                    )
                }
            } label: {
                Text("Εγγραφή")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(viewModel.isLoading)

            Spacer()
        }
        .padding()
    }
}
#Preview("Register") {
    RegisterView()
}

