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
    
    init() {
        jobRepo = JobRepositoryImpl()
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(getAssignedJobsUseCase: GetAssignedJobsUseCase(repository: jobRepo))
    }
}


