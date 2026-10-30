//
//  CreateJobPhotoDTO.swift
//  FieldOps
//
//  Created by Ahmed on 30/10/2026.
//

import Foundation

struct CreateJobPhotoDTO: Encodable {
    let jobId: UUID
    let type: String
    let storagePath: String
    
    enum CodingKeys: String, CodingKey {
        case jobId = "job_id"
        case type
        case storagePath = "storage_path"
    }
}
