//
//  JobDetailsView.swift
//  FieldOps
//
//  Created by Ahmed on 19/10/2026.
//

import SwiftUI

import SwiftUI

struct JobDetailsView: View {
    let job: Job

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(job.title)
                        .font(.title2.bold())
                        .foregroundStyle(Color("MainText"))

                    if let description = job.description {
                        Text(description)
                            .font(.body)
                            .foregroundStyle(Color("SmallText"))
                    }
                }
                
                detailSection(title: "Job Information") {
                    detailRow(
                        title: "Priority",
                        value: job.priority.displayName
                    )

                    detailRow(
                        title: "Status",
                        value: job.status.diplayName
                    )

                    detailRow(
                        title: "Scheduled Date",
                        value: job.scheduledAt.formatted(
                            date: .abbreviated,
                            time: .omitted
                        )
                    )

                    detailRow(
                        title: "Scheduled Time",
                        value: job.scheduledAt.formatted(
                            date: .omitted,
                            time: .shortened
                        )
                    )
                }

                detailSection(title: "Customer") {
                    detailRow(
                        title: "Customer ID",
                        value: job.customerId.uuidString
                    )
                }
            }
            .padding(20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Job Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func detailSection<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)

            content()
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    private func detailRow(
        title: String,
        value: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(Color("MainText"))
                .textSelection(.enabled)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    JobDetailsView(job: Job(id: UUID(), customerId: UUID(), technicianId: UUID(), title: "Air Conditoner maintenance", description: "Inspect the AC unit, clean the filters, and check the cooling performance.", priority: .high, status: .assigned, scheduledAt: Date()))
}
