//
//  SignInUseCase.swift
//  FieldOps
//
//  Created by Ahmed on 15/10/2026.
//

import Foundation

struct SignInUseCase {
    
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute(email: String, password: String) async throws {
        try await repository.signIn(email: email, password: password)
    }
}
