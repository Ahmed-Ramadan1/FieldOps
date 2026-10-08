//
//  GetAssignedJobsUseCase.swift
//  FieldOps
//
//  Created by Ahmed on 08/10/2026.
//

import Foundation

struct GetAssignedJobsUseCase {
    
    private let repository: JobRepository
    
    init(repository: JobRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Job] {
       try await repository.getAssignedJobs()
    }
    
}
