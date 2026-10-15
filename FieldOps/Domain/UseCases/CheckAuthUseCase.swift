//
//  CheckAuthenticationUseCase.swift
//  FieldOps
//
//  Created by Ahmed on 15/10/2026.
//

import Foundation

struct CheckAuthUseCase {
    
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute() async -> Bool {
        await repository.isAuthenticated()
    }
}
