//
//  CustomerRepository.swift
//  FieldOps
//
//  Created by Ahmed on 19/10/2026.
//

import Foundation

protocol CustomerRepository {
    
    func getCustomer(by id: UUID) async throws -> Customer?
}
