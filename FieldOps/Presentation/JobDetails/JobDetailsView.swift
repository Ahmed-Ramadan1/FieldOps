//
//  JobDetailsView.swift
//  FieldOps
//
//  Created by Ahmed on 23/10/2026.
//

import SwiftUI

struct JobDetailsView: View {
    @StateObject private var viewModel: JobDetailsViewModel
    @Environment(\.openURL) private var openURL

    init(viewModel: JobDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    private var job: Job {
        viewModel.job
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                jobHeader
                scheduleCard
                customerSection
            }
            .padding(20)
            .padding(.bottom, 20)
        }
        .background(FieldOpsColors.background.ignoresSafeArea())
        .navigationTitle("Job Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadCustomer()
        }
    }

    // MARK: - Job Header

    private var jobHeader: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "wrench.and.screwdriver.fill")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(FieldOpsColors.primary)
                    .frame(width: 52, height: 52)
                    .background(FieldOpsColors.lightOrange)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                VStack(alignment: .leading, spacing: 6) {
                    Text(job.title)
                        .font(.title2.bold())
                        .foregroundStyle(FieldOpsColors.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Service Job")
                        .font(.subheadline)
                        .foregroundStyle(FieldOpsColors.textSecondary)
                }

                Spacer(minLength: 0)
            }

            if let description = job.description,
               !description.isEmpty {
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(FieldOpsColors.textSecondary)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }

            HStack(spacing: 10) {
                statusBadge
                priorityBadge
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay {
            RoundedRectangle(cornerRadius: 22)
                .stroke(FieldOpsColors.border, lineWidth: 1)
        }
    }

    // MARK: - Status and Priority

    private var statusBadge: some View {
        Label(job.status.displayName, systemImage: "circle.fill")
            .font(.caption.weight(.semibold))
            .foregroundStyle(statusColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .background(statusColor.opacity(0.10))
            .clipShape(Capsule())
    }

    private var priorityBadge: some View {
        Text("\(job.priority.displayName) Priority")
            .font(.caption.weight(.semibold))
            .foregroundStyle(priorityColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .background(priorityColor.opacity(0.10))
            .clipShape(Capsule())
    }

    private var statusColor: Color {
        switch job.status {
        case .completed:
            return FieldOpsColors.success
        case .cancelled:
            return FieldOpsColors.textSecondary
        case .inProgress, .onTheWay, .arrived:
            return FieldOpsColors.primary
        case .assigned:
            return FieldOpsColors.deepOrange
        }
    }

    private var priorityColor: Color {
        switch job.priority {
        case .low:
            return FieldOpsColors.textSecondary
        case .medium:
            return FieldOpsColors.primary
        case .high, .urgent:
            return FieldOpsColors.deepOrange
        }
    }

    // MARK: - Schedule

    private var scheduleCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            sectionTitle("Schedule", symbol: "calendar")

            detailRow(
                symbol: "calendar",
                title: "Date",
                value: job.scheduledAt.formatted(date: .long, time: .omitted)
            )

            Divider()
                .overlay(FieldOpsColors.border)

            detailRow(
                symbol: "clock",
                title: "Scheduled Time",
                value: job.scheduledAt.formatted(
                    date: .omitted,
                    time: .shortened
                )
            )
        }
        .padding(20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay {
            RoundedRectangle(cornerRadius: 22)
                .stroke(FieldOpsColors.border, lineWidth: 1)
        }
    }

    // MARK: - Customer

    private var customerSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            sectionTitle("Customer Details", symbol: "person.crop.circle")

            if let customer = viewModel.customer {
                customerInformation(customer)
            } else if viewModel.isLoading {
                HStack(spacing: 12) {
                    ProgressView()
                        .tint(FieldOpsColors.primary)

                    Text("Loading customer information...")
                        .font(.subheadline)
                        .foregroundStyle(FieldOpsColors.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 12)
            } else if viewModel.customerNotFound {
                messageView(
                    symbol: "person.crop.circle.badge.questionmark",
                    title: "Customer not found",
                    message: "No accessible customer record was found for this job.",
                    buttonTitle: "Try Again"
                ) {
                    await viewModel.retryLoadingCustomer()
                }
            } else if viewModel.errorMessage != nil {
                messageView(
                    symbol: "wifi.exclamationmark",
                    title: "Couldn't load customer",
                    message: viewModel.errorMessage
                        ?? "Please try again.",
                    buttonTitle: "Retry"
                ) {
                    await viewModel.retryLoadingCustomer()
                }
            } else {
                EmptyView()
            }
        }
        .padding(20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay {
            RoundedRectangle(cornerRadius: 22)
                .stroke(FieldOpsColors.border, lineWidth: 1)
        }
    }

    private func customerInformation(_ customer: Customer) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            detailRow(
                symbol: "person.fill",
                title: "Customer Name",
                value: customer.name
            )

            Divider()
                .overlay(FieldOpsColors.border)

            VStack(alignment: .leading, spacing: 10) {
                Label("Phone Number", systemImage: "phone")
                    .font(.caption)
                    .foregroundStyle(FieldOpsColors.textSecondary)

                if let phone = customer.phone,
                   !phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    HStack {
                        Text(phone)
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(FieldOpsColors.textPrimary)
                            .textSelection(.enabled)

                        Spacer()

                        Button {
                            if let url = URL(string: "tel:\(phone)") {
                                openURL(url)
                            }
                        } label: {
                            Image(systemName: "phone.fill")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(width: 42, height: 42)
                                .background(FieldOpsColors.primary)
                                .clipShape(RoundedRectangle(cornerRadius: 13))
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Call customer")
                    }
                } else {
                    Text("No phone number provided")
                        .font(.subheadline)
                        .foregroundStyle(FieldOpsColors.textSecondary)
                }
            }

            Divider()
                .overlay(FieldOpsColors.border)

            detailRow(
                symbol: "mappin.and.ellipse",
                title: "Service Address",
                value: customer.address
            )

            if let latitude = customer.latitude,
               let longitude = customer.longitude {
                Button {
                    let urlString =
                        "https://maps.apple.com/?ll=\(latitude),\(longitude)"

                    if let url = URL(string: urlString) {
                        openURL(url)
                    }
                } label: {
                    Label("View Location in Maps", systemImage: "map")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(FieldOpsColors.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(FieldOpsColors.lightOrange)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .buttonStyle(.plain)
            }
        }
    }

    // MARK: - Reusable Components

    private func sectionTitle(
        _ title: String,
        symbol: String
    ) -> some View {
        Label {
            Text(title)
                .font(.headline)
                .foregroundStyle(FieldOpsColors.textPrimary)
        } icon: {
            Image(systemName: symbol)
                .foregroundStyle(FieldOpsColors.primary)
        }
    }

    private func detailRow(
        symbol: String,
        title: String,
        value: String
    ) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: symbol)
                .font(.system(size: 16))
                .foregroundStyle(FieldOpsColors.primary)
                .frame(width: 22)

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(FieldOpsColors.textSecondary)

                Text(value)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(FieldOpsColors.textPrimary)
                    .fixedSize(horizontal: false, vertical: true)
                    .textSelection(.enabled)
            }

            Spacer(minLength: 0)
        }
    }

    private func messageView(
        symbol: String,
        title: String,
        message: String,
        buttonTitle: String,
        action: @escaping () async -> Void
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title, systemImage: symbol)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(FieldOpsColors.textPrimary)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(FieldOpsColors.textSecondary)

            Button {
                Task {
                    await action()
                }
            } label: {
                Text(buttonTitle)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 11)
                    .background(FieldOpsColors.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.plain)
            .disabled(viewModel.isLoading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
#Preview {
    let job = Job(id: UUID(), customerId: UUID(), technicianId: UUID(), title: "Air Conditoner maintenance", description: "Inspect the AC unit, clean the filters, and check the cooling performance.", priority: .high, status: .assigned, scheduledAt: Date())
                       
    JobDetailsView(viewModel: AppDependencies.shared.makeJobDetailsViewModel(job: job))
}
