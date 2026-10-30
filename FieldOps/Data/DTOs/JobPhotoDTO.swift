//
//  JobPhotoDTO.swift
//  FieldOps
//
//  Created by Ahmed on 30/10/2026.
//

import Foundation

struct JobPhotoDTO: Decodable {
    let id: UUID
    let jobId: UUID
    let type: String
    let storagePath: String
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case jobId = "job_id"
        case type
        case storagePath = "storage_path"
        case createdAt = "created_at"
    }
}
