//
//  JobRepository.swift
//  FieldOps
//
//  Created by Ahmed on 08/10/2026.
//

import Foundation
import Supabase

final class JobRepositoryImpl: JobRepository {
    
    private let client = SupabaseManager.shared.client
    
    func getAssignedJobs() async throws -> [Job] {
        
        let jobs: [JobDTO] = try await client
            .from("jobs")
            .select()
            .order("scheduled_at")
            .execute()
            .value
        return jobs.map { $0.toDomain() }
    }
  
}
