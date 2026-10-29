//
//  AppDependencies.swift
//  FieldOps
//
//  Created by Ahmed on 10/10/2026.
//

import Foundation

final class AppDependencies {
    
    static let shared = AppDependencies()
    
    private let jobRepo: JobRepository
    private let authRepository: AuthRepository
    private let customerRepo: CustomerRepository
    private let workRepo: WorkReportRepository
    
    init() {
        jobRepo = JobRepositoryImpl()
        authRepository = AuthRepositoryImpl()
        customerRepo = CustomerRepositoryImpl()
        workRepo = WorkReportRepositoryImpl()
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(getAssignedJobsUseCase: GetAssignedJobsUseCase(repository: jobRepo))
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(signInUseCase: SignInUseCase(repository: authRepository))
    }

    func makeSignOutUseCase() -> SignOutUseCase {
        SignOutUseCase(repository: authRepository)
    }

    func makeCheckAuthenticationUseCase() -> CheckAuthUseCase {
        CheckAuthUseCase(repository: authRepository)
    }
    
    func makeGetCustomerByIdUseCase() -> GetCustomerByIdUseCase {
        GetCustomerByIdUseCase(repository: customerRepo)
    }
    
    func makeUpdateJobStatusUseCase() -> UpdateJobStatusUseCase {
        UpdateJobStatusUseCase(repository: jobRepo)
    }
    
    func makeJobDetailsViewModel(job: Job) -> JobDetailsViewModel {
        JobDetailsViewModel(job: job, getCustomerByIdUseCase: makeGetCustomerByIdUseCase(), updateJobStatusUseCase: makeUpdateJobStatusUseCase())
    }
    
    func makeSubmitWorkReportUseCase() -> SubmitWorkReportUseCase {
        SubmitWorkReportUseCase(repository: workRepo)
    }
}


