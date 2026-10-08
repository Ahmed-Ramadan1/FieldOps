//
//  JobRepository.swift
//  FieldOps
//
//  Created by Ahmed on 08/10/2026.
//

import Foundation
import Supabase

final class JobRepositoryImpl {
    private let client = SupabaseManager.shared.client
    
    func getJobs() async throws -> [JobDTO] {
        
       try await client
            .from("jobs")
            .select()
            .order("scheduled_at")
            .execute()
            .value
    }
}
