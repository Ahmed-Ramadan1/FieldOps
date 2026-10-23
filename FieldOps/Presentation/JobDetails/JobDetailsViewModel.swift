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
    
    let job: Job
    private let getCustomerByIdUseCase: GetCustomerByIdUseCase
    
    init(job: Job, getCustomerByIdUseCase: GetCustomerByIdUseCase) {
        self.job = job
        self.getCustomerByIdUseCase = getCustomerByIdUseCase
    }
    
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

    
}
