//
//  WorkReportViewModel.swift
//  FieldOps
//
//  Created by Ahmed on 09/11/2026.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI
import UniformTypeIdentifiers

@MainActor
final class WorkReportViewModel: ObservableObject {
    // MARK: - Job
    let job: Job
    
    // MARK: - Form Fields
    @Published var problem = ""
    @Published var workPerformed = ""
    @Published var partsUsed = ""
    @Published var notes = ""
    
    // MARK: - Selected Photos
    @Published var beforePhotos: [PhotosPickerItem] = []
    @Published var afterPhotos: [PhotosPickerItem] = []
    
    // MARK: - Submission State
    @Published private(set) var isSubmitting = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var successMessage: String?
    @Published private(set) var reportSubmitted = false
    
    // MARK - Use Cases
    private let submitWorkReportUseCase: SubmitWorkReportUseCase
    private let uploadJobPhotoUseCase: UploadJobPhotoUseCase
    
    // MARK - Initializer
    init(job: Job, submitWorkReportUseCase: SubmitWorkReportUseCase, uploadJobPhotoUseCase: UploadJobPhotoUseCase) {
        self.job = job
        self.submitWorkReportUseCase = submitWorkReportUseCase
        self.uploadJobPhotoUseCase = uploadJobPhotoUseCase
    }
    
    // MARK: - Validation
    var canSubmit: Bool {
        job.status == .inProgress &&
        !problem.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !workPerformed.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !isSubmitting &&
        !reportSubmitted
    }
    
    // MARK: - Submit Report
    
    func submitReport() async {
        
        guard canSubmit else { return }
        
        isSubmitting = true
        errorMessage = nil
        successMessage = nil
        
        defer {
            isSubmitting = false
        }
        
        do {
            // 1. Submit the text report first.
            _ = try await submitWorkReportUseCase.execute(job: job, problem: problem, workPerformed: workPerformed, partsUsed: partsUsed, notes: notes)
            
            reportSubmitted = true
            
            // 2. Upload before and after photos.
            let totalPhotos = beforePhotos.count + afterPhotos.count
            var uploadedPhotos = 0
            // before
            for item in beforePhotos {
                if await uploadPhoto(item, type: .before) {
                    uploadedPhotos += 1
                }
            }
            // after
            for item in afterPhotos {
                if await uploadPhoto(item, type: .after) {
                    uploadedPhotos += 1
                }
            }
            
            // 3. Report the final result.
            if uploadedPhotos == totalPhotos {
                successMessage = "Work report submitted successfully."
            } else {
                let failedPhotos = totalPhotos - uploadedPhotos

                successMessage = """
                Work report saved, but \(failedPhotos) photo(s) could not be uploaded. \
                \(uploadedPhotos) of \(totalPhotos) photos uploaded successfully.
                """
            }
            
        } catch SubmitWorkReportError.jobNotInProgress {
            errorMessage = "The job must be In Progress before submitting a report."
        } catch SubmitWorkReportError.emptyProblem {
            errorMessage = "Please describe the problem."
        } catch SubmitWorkReportError.emptyWorkPerformed {
            errorMessage = "Please describe the work performed."
        } catch {
            errorMessage = "Couldn't submit the work report. Please try again."
        }
        
        
    }
    
    // MARK: - Upload Photo
    private func uploadPhoto( _ item: PhotosPickerItem, type: JobPhoto.PhotoType) async -> Bool {
        
        do {
            
            guard let data = try await item.loadTransferable(type: Data.self) else {
                return false
            }
            
            let contentType = item.supportedContentTypes.first(where: { $0.conforms(to: .image)})?.preferredMIMEType ?? "image/jpeg"
            
            _ = try await uploadJobPhotoUseCase.execute(job: job, type: type, data: data, contentType: contentType)
            return true
            
        } catch {
            return false
        }
    }
}
