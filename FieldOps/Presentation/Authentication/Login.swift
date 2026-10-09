//
//  Login.swift
//  FieldOps
//
//  Created by Ahmed on 08/10/2026.
//

import SwiftUI

struct Login: View {
    @State var vm = LoginViewModel()
    var body: some View {
        Button("Login") {
            Task {
                await vm.login(
                    email: "technician@fieldops.com",
                    password: "Technician123!"
                )
                
                let repository = JobRepositoryImpl()

                Task {
                    do {
                        let jobs = try await repository.getAssignedJobs()

                        print(jobs)

                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    Login()
}
