//
//  Login.swift
//  FieldOps
//
//  Created by Ahmed on 08/10/2026.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel: LoginViewModel
    @State private var isPasswordVisible = false

    private let onLoginSuccess: () -> Void

    init(
        viewModel: LoginViewModel,
        onLoginSuccess: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onLoginSuccess = onLoginSuccess
    }

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Brand
            VStack(spacing: 12) {
                Image(systemName: "wrench.and.screwdriver.fill")
                    .font(.system(size: 34, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 76, height: 76)
                    .background(Color.orange)
                    //.background(Color("SecText"))
                    .clipShape(RoundedRectangle(cornerRadius: 22))

                Text("FieldOps")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(Color.primary)

                Text("Work, handled.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Welcome back")
                        .font(.title2.bold())

                    Text("Sign in to manage your service jobs.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                // Email
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.subheadline.weight(.medium))

                    HStack(spacing: 12) {
                        Image(systemName: "envelope")
                            .foregroundStyle(.secondary)

                        TextField(
                            "Enter your email",
                            text: $viewModel.email
                        )
                        .keyboardType(.emailAddress)
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    }
                    .padding(16)
                    .background(FieldOpsColors.background)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }

                // Password
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.subheadline.weight(.medium))

                    HStack(spacing: 12) {
                        Image(systemName: "lock")
                            .foregroundStyle(.secondary)

                        Group {
                            if isPasswordVisible {
                                TextField(
                                    "Enter your password",
                                    text: $viewModel.password
                                )
                            } else {
                                SecureField(
                                    "Enter your password",
                                    text: $viewModel.password
                                )
                            }
                        }
                        .textContentType(.password)

                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(
                                systemName: isPasswordVisible
                                    ? "eye.slash"
                                    : "eye"
                            )
                            .foregroundStyle(.secondary)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel(
                            isPasswordVisible
                                ? "Hide password"
                                : "Show password"
                        )
                    }
                    .padding(16)
                    .background(FieldOpsColors.background)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }

                // Error
                if let errorMessage = viewModel.errorMessage {
                    Label(
                        errorMessage,
                        systemImage: "exclamationmark.circle"
                    )
                    .font(.subheadline)
                    .foregroundStyle(.red)
                    .fixedSize(horizontal: false, vertical: true)
                }

                // Sign in
                Button {
                    Task {
                        await viewModel.singIn()

                        if viewModel.loginSucceeded {
                            onLoginSuccess()
                        }
                    }
                } label: {
                    HStack(spacing: 10) {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Sign In")
                            Image(systemName: "arrow.right")
                        }
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(Color.orange)
//                    .background(Color("SecText"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .disabled(viewModel.isLoading)
                .opacity(viewModel.isLoading ? 0.7 : 1)
            }
            .padding(24)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .padding(.top, 40)

            Spacer()

            Text("Secure access for your field team.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.bottom, 16)
        }
        .padding(.horizontal, 20)
        .background(FieldOpsColors.background)
    }
}

#Preview {
    LoginView(viewModel: AppDependencies.shared.makeLoginViewModel()) {
        
    }
}
