//
//  SignOutUseCase.swift
//  FieldOps
//
//  Created by Ahmed on 15/10/2026.
//

import Foundation

struct SignOutUseCase {
    
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute() async throws {
        try await repository.signOut()
    }
}
