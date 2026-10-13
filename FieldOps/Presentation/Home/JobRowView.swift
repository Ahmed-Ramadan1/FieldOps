//
//  JobRowView.swift
//  FieldOps
//
//  Created by Ahmed on 10/10/2026.
//

import SwiftUI

struct JobRowView: View {
    
    let job: Job
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text(job.title)
                    .font(Font.custom("Inter", size: 17)
                        .weight(.semibold))
                Text("AC maintenance")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
            }
        }
        
    }
}

#Preview {
    JobRowView(job: Job(id: UUID(), customerId: UUID(), technicianId: UUID(), title: "AC maintenance", description: "Inspect the AC unit, clean the filters, and check the cooling performance.", priority: .high, status: .arrived, scheduledAt: Date())).padding()
}
