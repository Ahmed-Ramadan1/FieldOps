//
//  JobPhoto.swift
//  FieldOps
//
//  Created by Ahmed on 29/10/2026.
//

import Foundation

struct JobPhoto: Identifiable {
    let id: UUID
    let jobId: UUID
    let type: PhotoType
    let storagePath: String
    let createdAt: Date

    enum PhotoType {
        case before
        case after
    }
}
