//
//  FieldOpsApp.swift
//  FieldOps
//
//  Created by Ahmed on 06/10/2026.
//

import SwiftUI

@main
struct FieldOpsApp: App {
    private let dependencies = AppDependencies()
    var body: some Scene {
        WindowGroup {
////            let jpp : JobRepository = JobRepositoryImpl()
////            HomeView(viewModel: HomeViewModel(getAssignedJobsUseCase: GetAssignedJobsUseCase(repository: jpp)))
//            
////            Login(viewModel: AppDependencies.shared.makeLoginViewModel(), onLoginSuccess: {print("it works")})
//            
//         OnboardingView(onFinished: {print("nooooo 😱")})
            
           RootView(dependencies: dependencies)
            
        }
    }
}




/*
 FieldOps/
 │
 ├── App/
 │
 ├── Core/
 │   ├── Supabase/
 │   ├── Networking/
 │   ├── Errors/
 │   └── Extensions/
 │
 ├── Presentation/
 │   ├── Authentication/
 │   │   ├── LoginView.swift
 │   │   └── LoginViewModel.swift
 │   │
 │   ├── Home/
 │   │   ├── HomeView.swift
 │   │   └── HomeViewModel.swift
 │   │
 │   ├── JobDetails/
 │   ├── WorkReport/
 │   └── Profile/
 │
 ├── Domain/
 │   ├── Entities/
 │   ├── UseCases/
 │   └── Repositories/
 │
 └── Data/
     ├── DTOs/
     ├── Mappers/
     └── Repositories/

 */

/**
 Primary: orange #F47735
 Pressed / deep orange: #E65F24
 Light orange: #FFF0E6
 Background: warm off-white #F7F6F2
 Primary text: charcoal #20252B
 Typography: SF Pro, using SwiftUI's system fonts
 Components: rounded cards, subtle borders, comfortable spacing, and clear status badges
 */
