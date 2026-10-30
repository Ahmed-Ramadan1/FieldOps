//
//  JobPhotoRepositoryImpl.swift
//  FieldOps
//
//  Created by Ahmed on 30/10/2026.
//

import Foundation
import Supabase

final class JobPhotoRepositoryImpl: JobPhotoRepository {
    
    private let client = SupabaseManager.shared.client
    
    func uploadPhoto(jobId: UUID, type: JobPhoto.PhotoType, data: Data, contentType: String) async throws -> JobPhoto {
        
        // 1. Convert the Domain enum into the database value.
        let databaseType: String
        switch type {
        case .before:
            databaseType = "before"
        case .after:
            databaseType = "after"
        }
        
        // 2. Create a unique path inside the private bucket.
        // Example: <job-uuid>/<unique-photo-uuid>
        let storagePath = "\(jobId.uuidString)/\(UUID().uuidString)"
        
        // 3. Upload the actual image bytes to Supabase Storage.
        try await client.storage
            .from("job-photos")
            .upload(storagePath, data: data, options: FileOptions(cacheControl: "3600", contentType: contentType, upsert: false))
        
        // 4. Save the photo's metadata in the job_photos table.
        let payload = CreateJobPhotoDTO(jobId: jobId, type: databaseType, storagePath: storagePath)
        
        do {
            let createdPhoto: JobPhotoDTO = try await client
                .from("job_photos")
                .insert(payload)
                .select()
                .single()
                .execute()
                .value
            return try createdPhoto.toDomain()
        } catch {
            // Avoid leaving an orphaned Storage object if metadata
            // insertion fails.
            _ = try? await client.storage
                .from("job-photos")
                .remove(paths: [storagePath])
            
            throw error
        }
    }
    
    
}
