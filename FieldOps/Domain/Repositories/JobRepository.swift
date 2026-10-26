//
//  JobRepository.swift
//  FieldOps
//
//  Created by Ahmed on 08/10/2026.
//

import Foundation

protocol JobRepository {
    
    func getAssignedJobs() async throws -> [Job]
    
    func updateStatus(jobId: UUID, to status: Job.Status) async throws -> Job
}
