//
//  AuthRepository.swift
//  FieldOps
//
//  Created by Ahmed on 07/10/2026.
//

import Foundation
import Supabase


final class AuthRepository {
    
    private let client = SupabaseManager.shared.client
    
    func login(email: String, password: String) async throws {
      try await client.auth.signIn(email: email, password: password)
    }
}
