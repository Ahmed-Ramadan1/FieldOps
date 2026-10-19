//
//  CustomerRepositoryImpl.swift
//  FieldOps
//
//  Created by Ahmed on 19/10/2026.
//

import Foundation
import Supabase

final class CustomerRepositoryImpl: CustomerRepository {
    
    private let client = SupabaseManager.shared.client
    
    func getCustomer(by id: UUID) async throws -> Customer? {
        let customers: [CustomerDTO] = try await client
            .from("customers")
            .select()
            .eq("id", value: id.uuidString)
            .limit(1)
            .execute()
            .value
        
        guard let customerDTO = customers.first else { return nil }
        
        return customerDTO.toDomain()
        
    }
    
    
}
