import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var selectedDirection: Direction = .science
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    private var isEmailValid: Bool {
        let pattern = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        return email.range(of: pattern, options: [.regularExpression, .caseInsensitive]) != nil
    }

    private var isPasswordValid: Bool {
        return password.count >= 8
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Δημιουργία λογαριασμού")
                            .font(.title.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Name Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Όνομα")
                            .font(.headline)
                        TextField("Όνομα", text: $name)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.name)
                            .autocapitalization(.words)
                    }
                    
                    // Direction Picker
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Κατεύθυνση")
                            .font(.headline)
                        Picker("Κατεύθυνση", selection: $selectedDirection) {
                            ForEach(Direction.allCases) { direction in
                                Text(direction.localizedName).tag(direction)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .tint(.accentColor)
                    }
                    
                    // Email Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.headline)
                        TextField("Email", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                    }
                    
                    // Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Κωδικός")
                            .font(.headline)
                        SecureField("Κωδικός", text: $password)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.newPassword)
                            .autocapitalization(.none)
                    }
                    
                    // Confirm Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Επιβεβαίωση Κωδικού")
                            .font(.headline)
                        SecureField("Επιβεβαίωση Κωδικού", text: $confirmPassword)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.newPassword)
                            .autocapitalization(.none)
                    }
                    
                    // Error Message
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    // Register Button
                    Button {
                        guard password == confirmPassword else {
                            viewModel.errorMessage = "Οι κωδικοί δεν ταιριάζουν"
                            return
                        }
                        
                        Task {
                            await viewModel.signUp(
                                name: name,
                                direction: selectedDirection,
                                email: email,
                                password: password
                            )
                        }
                    } label: {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Εγγραφή")
                                .font(.headline)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .disabled(viewModel.isLoading || !isFormValid)
                    .opacity((viewModel.isLoading || !isFormValid) ? 0.6 : 1)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .onChange(of: viewModel.currentUser?.id) { _, newValue in
            if newValue != nil { dismiss() }
        }
    }
      
    private var isFormValid: Bool {
        !name.isEmpty &&
        isEmailValid &&
        isPasswordValid &&
        password == confirmPassword
    }
}

#Preview("Register") {
    RegisterView()
        .environmentObject(AuthViewModel())
}
