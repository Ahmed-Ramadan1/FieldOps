//
//  AuthRepository.swift
//  FieldOps
//
//  Created by Ahmed on 07/10/2026.
//

import Foundation
import Supabase


final class AuthRepositoryImpl: AuthRepository {
    
    private let client = SupabaseManager.shared.client

    func signIn(email: String, password: String) async throws {
        try await client.auth.signIn(email: email, password: password)
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    func isAuthenticated() async -> Bool {
        do {
          _ = try await client.auth.session
            return true
        } catch {
            return false
        }
    }
    
}
