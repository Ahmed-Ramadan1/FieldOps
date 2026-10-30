//
//  JobPhotoMapper.swift
//  FieldOps
//
//  Created by Ahmed on 30/10/2026.
//

import Foundation

enum JobPhotoMappingError: Error {
    case unknownPhotoType(String)
}

extension JobPhotoDTO {
    func toDomain() throws -> JobPhoto {
        let photoType: JobPhoto.PhotoType
        
        switch type {
            case "before":
            photoType = .before
            case "after":
            photoType = .after
        default:
            throw JobPhotoMappingError.unknownPhotoType(type)
    }

       return JobPhoto(id: id, jobId: jobId, type: photoType, storagePath: storagePath, createdAt: createdAt)
    }
}
