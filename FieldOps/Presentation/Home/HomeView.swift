//
//  HomeView.swift
//  FieldOps
//
//  Created by Ahmed on 10/10/2026.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        NavigationStack {
        Group {
            
                
                if viewModel.isLoading {
                    ProgressView("Loading jobs...")
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text(error)
                            .foregroundStyle(.red)
                        Button("Try Again") {
                            Task {
                                await viewModel.loadJobs()
                                
                            }
                        }
                    }
                    .padding()
                } else if viewModel.jobs.isEmpty {
                    ContentUnavailableView("No Jobs Assigned", systemImage: "wrench.and.screwdriver", description: Text("Your assigned maintenance jobs will appear here."))
                } else {
                    
                }
                
            }
        .navigationTitle("My Jobs")
        }
        .task {
            await viewModel.loadJobs()
        }
    }
}

#Preview {
    let jpp : JobRepository = JobRepositoryImpl()
    HomeView(viewModel: HomeViewModel(getAssignedJobsUseCase: GetAssignedJobsUseCase(repository: jpp)))
}
