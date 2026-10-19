//
//  GetCustomerByIdUseCase.swift
//  FieldOps
//
//  Created by Ahmed on 19/10/2026.
//

import Foundation

struct GetCustomerByIdUseCase {
    
    private let repository: CustomerRepository
    
    init(repository: CustomerRepository) {
        self.repository = repository
    }
    
    func execute(id: UUID) async throws -> Customer? {
        try await repository.getCustomer(by: id)
    }
}
