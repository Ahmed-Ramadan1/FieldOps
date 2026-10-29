//
//  WorkReport.swift
//  FieldOps
//
//  Created by Ahmed on 29/10/2026.
//

import Foundation

struct WorkReport: Identifiable {
    let id: UUID
    let jobId: UUID
    let problem: String
    let workPerformed: String
    let partsUsed: String?
    let notes: String?
    let createdAt: Date
}
