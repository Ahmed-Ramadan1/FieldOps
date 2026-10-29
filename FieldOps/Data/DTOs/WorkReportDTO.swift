//
//  WorkReportDTO.swift
//  FieldOps
//
//  Created by Ahmed on 29/10/2026.
//

import Foundation

struct WorkReportDTO: Decodable {
    let id: UUID
    let jobId: UUID
    let problem: String
    let workPerformed: String
    let partsUsed: String?
    let notes: String?
    let createdAt: Date
    let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case jobId = "job_id"
        case problem
        case workPerformed = "work_performed"
        case partsUsed = "parts_used"
        case notes
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
