//
//  JobPhotoRepository.swift
//  FieldOps
//
//  Created by Ahmed on 30/10/2026.
//

import Foundation

protocol JobPhotoRepository {
    
    func uploadPhoto(jobId: UUID, type: JobPhoto.PhotoType, data: Data, contentType: String) async throws -> JobPhoto
}
