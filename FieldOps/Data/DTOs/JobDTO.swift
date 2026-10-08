//
//  JobDTO.swift
//  FieldOps
//
//  Created by Ahmed on 08/10/2026.
//

import Foundation

struct JobDTO: Decodable {

    let id: UUID
    let customerId: UUID
    let technicianId: UUID
    let title: String
    let description: String?
    let priority: String
    let status: String
    let scheduledAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case customerId = "customer_id"
        case technicianId = "technician_id"
        case title
        case description
        case priority
        case status
        case scheduledAt = "scheduled_at"
    }
}
