//
//  AuthRepository.swift
//  FieldOps
//
//  Created by Ahmed on 15/10/2026.
//

import Foundation

protocol AuthRepository {
    
    func signIn(email: String, password: String) async throws
    
    func signOut() async throws
    
    func isAuthenticated() async -> Bool
}
