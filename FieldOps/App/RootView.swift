//
//  RootView.swift
//  FieldOps
//
//  Created by Ahmed on 16/10/2026.
//

import SwiftUI

struct RootView: View {
    @AppStorage("hasCompletedOnboarding")
    private var hasCompletedOnboarding = false

    @State private var isAuthenticated: Bool? = nil

    private let dependencies: AppDependencies

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }

    var body: some View {
        Group {
            if !hasCompletedOnboarding {
                OnboardingView {
                    finishOnboarding()
                }
            } else if let isAuthenticated {
                if isAuthenticated {
                    HomeView(
                        viewModel: dependencies.makeHomeViewModel()
                    )
                } else {
                    LoginView(
                        viewModel: dependencies.makeLoginViewModel()
                    ) {
                        self.isAuthenticated = true
                    }
                }
            } else {
                ProgressView("Checking session...")
            }
        }
        .task {
            await checkAuthentication()
        }
    }

    private func finishOnboarding() {
        hasCompletedOnboarding = true

        Task {
            await checkAuthentication()
        }
    }

    @MainActor
    private func checkAuthentication() async {
        guard hasCompletedOnboarding else { return }

        let useCase = dependencies.makeCheckAuthenticationUseCase()
        isAuthenticated = await useCase.execute()
    }
}

#Preview {
     let dependencies = AppDependencies()
    RootView(dependencies: dependencies)
}
