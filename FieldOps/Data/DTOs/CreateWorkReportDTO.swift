//
//  CreateWorkReportDTO.swift
//  FieldOps
//
//  Created by Ahmed on 29/10/2026.
//

import Foundation

struct CreateWorkReportDTO: Encodable {
    let jobId: UUID
    let problem: String
    let workPerformed: String
    let partsUsed: String?
    let notes: String?

    enum CodingKeys: String, CodingKey {
        case jobId = "job_id"
        case problem
        case workPerformed = "work_performed"
        case partsUsed = "parts_used"
        case notes
    }
}
