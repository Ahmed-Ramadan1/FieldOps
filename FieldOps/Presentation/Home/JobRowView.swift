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
                            .foregroundStyle(Color("SecText"))
                            .frame(width: 15, height: 15)
                        Text(job.title)
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("MainText"))
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
                        .foregroundStyle(Color("SmallText"))
                        .lineLimit(2)

                }
                Divider().padding(6)
                HStack(alignment: .center, spacing: 7) {
                    HStack(alignment: .center,spacing: 8) {
                      Image(systemName: "clock")
                            .foregroundStyle(Color("SmallText"))
                            .frame(width: 10, height: 0)
                        
                        Text(job.scheduledAt.formatted(
                            date: .omitted,
                            time: .shortened))
                            .font(.system(size: 13))
                           // .fontWeight(.semibold)
                            .foregroundStyle(Color("MainText"))
                    }
                        .padding(0)
                   
                    
                    Spacer()
                    Text(job.status.diplayName)
                        .font(.system(size: 10))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("SecText"))
                        .padding(.horizontal, 9)
                        .padding(.vertical, 5)
                        .background(Color(#colorLiteral(red: 0.8823529412, green: 0.9490196078, blue: 0.9411764706, alpha: 1)))
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
                    .stroke(Color(#colorLiteral(red: 0.8823529412, green: 0.9137254902, blue: 0.9137254902, alpha: 1)), lineWidth: 1)
            }
        
    }
    
    private var priorityColor: Color {
        switch job.priority {
        case .low, .medium:
            return Color("SecText")
        case .high:
            return Color(#colorLiteral(red: 0.6470588235, green: 0.4235294118, blue: 0.0862745098, alpha: 1))
        case .urgent:
            return .red
        }
    }
}

#Preview {
    
    
    JobRowView(job: Job(id: UUID(), customerId: UUID(), technicianId: UUID(), title: "Air Conditoner maintenance", description: "Inspect the AC unit, clean the filters, and check the cooling performance.", priority: .high, status: .assigned, scheduledAt: Date()))
    
}
