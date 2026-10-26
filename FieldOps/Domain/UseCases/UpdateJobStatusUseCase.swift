//
//  UpdateJobStatusUseCase.swift
//  FieldOps
//
//  Created by Ahmed on 26/10/2026.
//

import Foundation

struct UpdateJobStatusUseCase {
    
    let repository: JobRepository
    
    init(repository: JobRepository) {
        self.repository = repository
    }
    
    func execute(job: Job, to newStatus: Job.Status) async throws -> Job {
        guard canTransition(from: job.status, to: newStatus) else {
            throw UpdateJobStatusError.invalidTransition
        }
        
        return try await repository.updateStatus(jobId: job.id, to: newStatus)
    }
    
    private func canTransition(from current: Job.Status, to next: Job.Status) -> Bool {
        switch (current, next) {
        case (.assigned, .onTheWay),
                     (.onTheWay, .arrived),
                     (.arrived, .inProgress),
                     (.inProgress, .completed):
            return true
            
            default :
            return false
        }
    }
}

enum UpdateJobStatusError: Error {
    case invalidTransition
}

