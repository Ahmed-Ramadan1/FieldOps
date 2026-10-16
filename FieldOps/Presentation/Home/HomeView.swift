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
        ZStack {
            //backgruond color
            Color("BackgroundApp")
                .ignoresSafeArea()
            // all content
            VStack(alignment: .leading)  {
                // welcome message 
                VStack(alignment: .leading, spacing: 6) {
                    Text("Good morning, Ahmed")
                        .font(.system(size: 12))
                        .foregroundStyle(Color("SmallText"))
                    
                    Text("Let’s get to work.")
                        .font(.system(size: 26))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("MainText"))
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .leading)
                // today's date
                HStack(alignment: .center,spacing: 8) {
                  Image(systemName: "calendar")
                        .foregroundStyle(Color("SecText"))
                        .font(.system(size: 18))
                        .frame(width: 18, height: 18)
                    Text(Date(),style: .date)
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("MainText"))
                }
                    .padding(0)
                // progress
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .center) {
                        Text("\(viewModel.jobs.count) jobs today")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        HStack(spacing: 6) {
                            Image(systemName: "checkmark.circle")
                            Text("1 completed")
                                .font(.system(size: 12))
                        }
                        .foregroundColor(Color(#colorLiteral(red: 0.737254902, green: 0.9137254902, blue: 0.8549019608, alpha: 1)))
                        .padding(0)
                    }
                    .padding(0)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.white.opacity(0.2))
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.white)
                                .frame(width: geometry.size.width * 0.25)
                        }
                    }
                    .frame(height: 6)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, minHeight: 72, maxHeight: 72, alignment: .topLeading)
                .background(Color(red: 0.06, green: 0.24, blue: 0.27))
                .cornerRadius(18)
                
                
                ///8--===================
                .onTapGesture {
                    Task {
                      try await AppDependencies.shared.makeSignOutUseCase().execute()
                    }
                }
                
                // today's jobs
                HStack(alignment: .center) {
                    Text("Today’s jobs")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("MainText"))
                Spacer()
                    Text("\(viewModel.jobs.count) remaining")
                        .font(.system(size: 12))
                        .foregroundStyle(Color("SmallText"))
                }
                .padding(0)
                .frame(maxWidth: .infinity, minHeight: 28, maxHeight: 28, alignment: .center)
                
                // all jobs list
                NavigationStack {
                    Group {
                        
                        
                        if viewModel.isLoading {
                            ProgressView("Loading jobs...")
                                .background(Color("BackgroundApp"))
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
                                .foregroundStyle(Color("MainText"))
                        } else {
                            List(viewModel.jobs) { job in
                                JobRowView(job: job)
                                    .padding(.vertical, 6)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets())
                                
                            }
                            .listStyle(.plain)
                            .scrollIndicators(.hidden)
                            
                            .refreshable {
                                await viewModel.loadJobs()
                            }
                        }
                        
                    }
                    .background(Color("BackgroundApp"))
                    
                   
                }
                .task {
                    await viewModel.loadJobs()
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            //.padding(.bottom, 20)
            .frame(maxWidth: .infinity,alignment: .leading)

        }
    }
}

#Preview {
    HomeView(viewModel: AppDependencies.shared.makeHomeViewModel())
}
