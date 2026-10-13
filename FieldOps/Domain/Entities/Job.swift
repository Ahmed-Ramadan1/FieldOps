//
//  Job.swift
//  FieldOps
//
//  Created by Ahmed on 08/10/2026.
//

import Foundation

struct Job: Identifiable {
    
    let id: UUID
    let customerId: UUID
    let technicianId: UUID
    let title: String
    let description: String?
    let priority: Priority
    let status: Status
    let scheduledAt: Date
    
}

extension Job {
    
    enum Priority {
        case low
        case medium
        case high
        case urgent
        
        var displayName: String {
            switch self {
            case .low: "Low"
            case .medium: "Medium"
            case .high: "High"
            case .urgent: "Urgent"
            }
        }
        
    }
    
    enum Status {
        case assigned
        case onTheWay
        case arrived
        case inProgress
        case completed
        case cancelled
        
        var diplayName: String {
            switch self {
            case .assigned: "Assigned"
            case .onTheWay: "On the way"
            case .arrived: "Arrived"
            case .inProgress: "In progress"
            case .completed: "Completed"
            case .cancelled: "Cancelled"
            }
        }
    }
}
