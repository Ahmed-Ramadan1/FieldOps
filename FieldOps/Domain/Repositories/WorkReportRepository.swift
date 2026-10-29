//
//  WorkReportRepository.swift
//  FieldOps
//
//  Created by Ahmed on 29/10/2026.
//

import Foundation

protocol WorkReportRepository {
    
    func submit(jobId: UUID, problem: String, workPerformed: String, partsUsed: String?, notes: String? ) async throws -> WorkReport
}
