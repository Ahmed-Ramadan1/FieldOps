//
//  SubmitWorkReportUseCase.swift
//  FieldOps
//
//  Created by Ahmed on 29/10/2026.
//

import Foundation

struct SubmitWorkReportUseCase {
    let repository: WorkReportRepository
    
    init(repository: WorkReportRepository) {
        self.repository = repository
    }
    
    func execute(job: Job, problem: String, workPerformed: String, partsUsed: String?, notes: String?) async throws -> WorkReport {
        
        guard job.status == .inProgress else {
            throw SubmitWorkReportError.jobNotInProgress
        }
        
        guard !problem.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw SubmitWorkReportError.emptyProblem
        }
        
        guard !workPerformed.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw SubmitWorkReportError.emptyWorkPerformed
        }
        
        
        return try await repository.submit(
            jobId: job.id,
            problem: problem.trimmingCharacters(in: .whitespacesAndNewlines),
            workPerformed: workPerformed.trimmingCharacters(in: .whitespacesAndNewlines),
            partsUsed: partsUsed?.nillfBlank,
            notes: notes?.nillfBlank
        )
    }
}

enum SubmitWorkReportError: Error {
    case jobNotInProgress
    case emptyProblem
    case emptyWorkPerformed
}

private extension String {
    var nillfBlank: String? {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }
}
