//
//  WorkReportRepositoryImpl.swift
//  FieldOps
//
//  Created by Ahmed on 29/10/2026.
//

import Foundation
import Supabase

final class WorkReportRepositoryImpl: WorkReportRepository {
    
    private let client = SupabaseManager.shared.client
    
    func submit(jobId: UUID, problem: String, workPerformed: String, partsUsed: String?, notes: String?) async throws -> WorkReport {
        
        let payload = CreateWorkReportDTO(jobId: jobId, problem: problem, workPerformed: workPerformed, partsUsed: partsUsed, notes: notes)
        
        let createdReport: WorkReportDTO = try await client
            .from("work_reports")
            .insert(payload)
            .select()
            .single()
            .execute()
            .value
        return createdReport.toDomain()
    }
    
}
