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
    
    init() {
        jobRepo = JobRepositoryImpl()
        authRepository = AuthRepositoryImpl()
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
}


