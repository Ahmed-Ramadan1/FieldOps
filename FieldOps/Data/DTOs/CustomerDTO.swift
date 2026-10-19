//
//  CustomerDTO.swift
//  FieldOps
//
//  Created by Ahmed on 19/10/2026.
//

import Foundation

struct CustomerDTO: Decodable {
    let id: UUID
    let name: String
    let phone: String?
    let address: String
    let latitude: Double?
    let longitude: Double?
    let createdAt: Date
    let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case phone
        case address
        case latitude
        case longitude
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

