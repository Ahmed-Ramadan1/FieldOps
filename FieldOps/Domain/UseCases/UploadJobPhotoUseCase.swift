//
//  UploadJobPhotoUseCase.swift
//  FieldOps
//
//  Created by Ahmed on 09/11/2026.
//

import Foundation

struct UploadJobPhotoUseCase {
    
    private let repository: JobPhotoRepository
    
    init(repository: JobPhotoRepository) {
        self.repository = repository
    }
    
    func execute(job: Job, type: JobPhoto.PhotoType, data: Data, contentType: String) async throws -> JobPhoto {
        guard job.status == .inProgress else {
            throw UploadJobPhotoError.jobNotInProgress
        }
        
        guard !data.isEmpty else {
            throw UploadJobPhotoError.emptyImage
        }
        
        return try await repository.uploadPhoto(jobId: job.id, type: type, data: data, contentType: contentType)
    }
}

enum UploadJobPhotoError: Error {
    case jobNotInProgress
    case emptyImage
}
