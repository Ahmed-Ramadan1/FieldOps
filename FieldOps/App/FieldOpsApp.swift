//
//  FieldOpsApp.swift
//  FieldOps
//
//  Created by Ahmed on 06/10/2026.
//

import SwiftUI

@main
struct FieldOpsApp: App {
    var body: some Scene {
        WindowGroup {
            Login()
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


