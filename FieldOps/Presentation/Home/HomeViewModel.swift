//
//  HomeViewModel.swift
//  FieldOps
//
//  Created by Ahmed on 10/10/2026.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published private(set) var jobs: [Job] = [Job(id: UUID(), customerId: UUID(), technicianId: UUID(), title: "AC Repair", description: "fix the AC", priority: .high, status: .arrived, scheduledAt: Date())]
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let getAssignedJobsUseCase: GetAssignedJobsUseCase
    
    init(getAssignedJobsUseCase: GetAssignedJobsUseCase) {
        self.getAssignedJobsUseCase = getAssignedJobsUseCase
    }
    
    func loadJobs() async {
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        do {
           // jobs = try await getAssignedJobsUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
