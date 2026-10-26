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

    
    func updateStatus(jobId: UUID, to status: Job.Status) async throws -> Job {
        
        let statusValue: String
        
        switch status {
        case .assigned: statusValue = "assigned"
        case .onTheWay: statusValue = "on_the_way"
        case .arrived: statusValue = "arrived"
        case .inProgress: statusValue = "in_progress"
        case .completed: statusValue = "completed"
        case .cancelled: statusValue = "cancelled"
            
        }
        
        let updatedJob: JobDTO = try await client
            .from("jobs")
            .update(["status": statusValue])
            .eq("id", value: jobId.uuidString)
            .select()
            .single()
            .execute()
            .value
        
        return updatedJob.toDomain()
    }
    
    
    
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
