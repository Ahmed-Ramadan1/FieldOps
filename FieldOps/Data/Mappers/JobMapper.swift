//
//  JobMapper.swift
//  FieldOps
//
//  Created by Ahmed on 09/10/2026.
//

import Foundation

extension JobDTO {
    
    func toDomain() -> Job {
        Job(id: id, customerId: customerId, technicianId: technicianId, title: title, description: description, priority: mapPriority(), status: mapStatus(), scheduledAt: scheduledAt)
    }
    
    private func mapPriority() -> Job.Priority {
        
        switch priority {
        case "low":
            return .low
        case "medium":
            return .medium
        case "high":
            return .high
        case "urgent":
            return .urgent
        default:
            return .medium
        }
    }
        
        private func mapStatus() -> Job.Status {
            
            switch status {
            case "assigned":
                return .assigned
            case "on_the_way":
                return .onTheWay
            case "arrived":
                return .arrived
            case "in_progress":
                return .inProgress
            case "completed":
                return .completed
            case "cancelled":
                return .cancelled
            default:
                return .assigned
        }
    }
}
