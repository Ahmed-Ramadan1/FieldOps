//
//  LoginViewModel.swift
//  FieldOps
//
//  Created by Ahmed on 07/10/2026.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var loginSucceeded = false
    
    private let signInUseCase: SignInUseCase
    
    init(signInUseCase: SignInUseCase) {
        self.signInUseCase = signInUseCase
    }
    
    func singIn() async {
        errorMessage = nil
        loginSucceeded = false
        
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedEmail.isEmpty else {
            errorMessage = "Please enter your email."
            return
        }
        guard trimmedEmail.contains("@"),
              trimmedEmail.contains(".") else {
            errorMessage = "Please enter a valid email address."
            return
        }
        guard !password.isEmpty else {
            errorMessage = "Please enter your password."
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await signInUseCase.execute(email: trimmedEmail, password: password)
            loginSucceeded = true
            print("login success")
        } catch {
            errorMessage = "Unable to sign in. Please check your credentials and try again."
        }
        
    }
}
