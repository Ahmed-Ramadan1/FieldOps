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
    
    @Published private(set) var jobs: [Job] = [
        Job(id: UUID(), customerId: UUID(), technicianId: UUID(), title: "AC Repair", description: "fix the AC", priority: .urgent, status: .arrived, scheduledAt: Date()),
        Job(id: UUID(), customerId: UUID(), technicianId: UUID(), title: "AC maintenance", description: "Inspect the AC unit, clean the filters, and check the cooling performance.", priority: .high, status: .assigned, scheduledAt: Date()),
        Job(id: UUID(), customerId: UUID(), technicianId: UUID(), title: "AC Repair", description: "fix the AC", priority: .low, status: .arrived, scheduledAt: Date()),
        Job(id: UUID(), customerId: UUID(), technicianId: UUID(), title: "AC maintenance", description: "Inspect the AC unit, clean the filters, and check the cooling performance.", priority: .medium, status: .assigned, scheduledAt: Date())
    ]
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
            jobs = try await getAssignedJobsUseCase.execute()
        } catch is CancellationError {
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
