//
//  WorkReportMapper.swift
//  FieldOps
//
//  Created by Ahmed on 29/10/2026.
//

import Foundation

extension WorkReportDTO {
    func toDomain() -> WorkReport {
        WorkReport(
            id: id,
            jobId: jobId,
            problem: problem,
            workPerformed: workPerformed,
            partsUsed: partsUsed,
            notes: notes,
            createdAt: createdAt
        )
    }
}
