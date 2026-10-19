//
//  Customer.swift
//  FieldOps
//
//  Created by Ahmed on 19/10/2026.
//

import Foundation

struct Customer: Identifiable {
    let id: UUID
    let name: String
    let phone: String?
    let address: String
    let latitude: Double?
    let longitude: Double?
}
