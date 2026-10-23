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
                HStack(alignment: .center, spacing: 7) {
                    
                    HStack(alignment: .center,spacing: 7) {
                      Image(systemName: "bolt")
                            .foregroundStyle(FieldOpsColors.primary)
                            .frame(width: 15, height: 15)
                        Text(job.title)
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundStyle(FieldOpsColors.textPrimary)
                            .lineLimit(1)
                    }
                        .padding(0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    Spacer()
                    Text("- \(job.priority.displayName) Priority")
                        .font(.system(size: 10))
                        .fontWeight(.semibold)
                        .foregroundStyle(priorityColor)

                }
                    .padding(0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let description = job.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundStyle(FieldOpsColors.textSecondary)
                        .lineLimit(2)

                }
                Divider().padding(6)
                HStack(alignment: .center, spacing: 7) {
                    HStack(alignment: .center,spacing: 8) {
                      Image(systemName: "clock")
                            .foregroundStyle(FieldOpsColors.primary)
                            .frame(width: 10, height: 0)
                        
                        Text(job.scheduledAt.formatted(
                            date: .omitted,
                            time: .shortened))
                            .font(.system(size: 13))
                           // .fontWeight(.semibold)
                            .foregroundStyle(FieldOpsColors.textPrimary)
                    }
                        .padding(0)
                   
                    
                    Spacer()
                    Text(job.status.displayName)
                        .font(.system(size: 10))
                        .fontWeight(.semibold)
                        .foregroundStyle(FieldOpsColors.deepOrange)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 5)
                        .background(FieldOpsColors.lightOrange)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 0.5)
                    .stroke(Color(FieldOpsColors.border), lineWidth: 1)
            }
        
    }
    
    private var priorityColor: Color {
        switch job.priority {
        case .low, .medium:
            return Color(FieldOpsColors.deepOrange)
        case .high:
            return Color(FieldOpsColors.primary)
        case .urgent:
            return .red
        }
    }
}

#Preview {
    
    
    JobRowView(job: Job(id: UUID(), customerId: UUID(), technicianId: UUID(), title: "Air Conditoner maintenance", description: "Inspect the AC unit, clean the filters, and check the cooling performance.", priority: .high, status: .assigned, scheduledAt: Date()))
    
}
