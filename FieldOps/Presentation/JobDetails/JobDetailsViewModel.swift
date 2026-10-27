//
//  JobDetailsViewModel.swift
//  FieldOps
//
//  Created by Ahmed on 23/10/2026.
//

import Foundation
import Combine

final class JobDetailsViewModel: ObservableObject {
    
    @Published private(set) var customer: Customer?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var customerNotFound: Bool = false
    @Published private(set) var errorMessage: String?
    
    @Published private(set) var job: Job
    @Published private(set) var isUpdatingStatus: Bool = false
    @Published private(set) var statusUpdateError: String?
    
    private let getCustomerByIdUseCase: GetCustomerByIdUseCase
    private let updateJobStatusUseCase: UpdateJobStatusUseCase
    
    init(job: Job, getCustomerByIdUseCase: GetCustomerByIdUseCase, updateJobStatusUseCase: UpdateJobStatusUseCase) {
        self.job = job
        self.getCustomerByIdUseCase = getCustomerByIdUseCase
        self.updateJobStatusUseCase = updateJobStatusUseCase
    }
    
    // MARK: - Customer
    func loadCustomer() async {
        guard !isLoading, customer == nil, !customerNotFound else { return }
        
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            let result = try await getCustomerByIdUseCase.execute(id: job.customerId)
            if let result {
                customer = result
            } else {
                customerNotFound = true
            }
        } catch {
            errorMessage = "Couldn't load customer information. Please try again."
        }
    }
    
    func retryLoadingCustomer() async {
        errorMessage = nil
        customerNotFound = false
        await loadCustomer()
    }
    
    // MARK: - Job Status
    
    var nextStatus: Job.Status? {
        switch job.status {
        case .assigned:
            return .onTheWay
        case .onTheWay:
            return .arrived
        case .arrived:
            return .inProgress
        case .inProgress:
            return .completed
        case .completed, .cancelled:
            return nil
        }
    }
    
    var nextStatusButtonTitle: String? {
        guard let nextStatus else {
            return nil
        }
        
        switch nextStatus {
        case .onTheWay:
            return "Start Journey"
        case .arrived:
            return "Mark as Arrived"
        case .inProgress:
            return "Start Work"
        case .completed:
            return "Complete Job"
        case .assigned, .cancelled:
            return nil
        }
        
    }
    
    func updateToNextStatus() async {
        guard let nextStatus, !isUpdatingStatus else {
            return
        }
        
        isUpdatingStatus = true
        statusUpdateError = nil
        
        defer {
            isUpdatingStatus = false
        }
        
        do {
            let updatedJob = try await updateJobStatusUseCase.execute(job: job, to: nextStatus)
            job = updatedJob
        } catch {
            statusUpdateError = "Couldn't update the job status. Please try again."
        }
    }
    
}
