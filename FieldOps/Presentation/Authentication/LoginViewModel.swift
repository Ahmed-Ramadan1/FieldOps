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
    @Published var errorMessage: String?
    private let authRepository = AuthRepositoryImpl()
    
    func login(email: String, password: String) async {
        
        do {
           try await authRepository.login(email: email, password: password)
            print("LogIN Success")
        } catch {
            errorMessage = error.localizedDescription
            print("\(errorMessage ?? "no message") helllllllp")
        }
    }
    
}
