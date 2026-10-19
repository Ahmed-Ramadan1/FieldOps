//
//  CustomerMapper.swift
//  FieldOps
//
//  Created by Ahmed on 19/10/2026.
//

import Foundation

extension CustomerDTO {
    
    func toDomain() -> Customer {
        Customer(id: id, name: name, phone: phone, address: address, latitude: latitude, longitude: longitude)
    }
}
