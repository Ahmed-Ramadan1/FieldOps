//
//  WorkReportView.swift
//  FieldOps
//
//  Created by Ahmed on 15/11/2026.
//

import SwiftUI
import PhotosUI

struct WorkReportView: View {

    @StateObject private var viewModel: WorkReportViewModel
    //@Environment(\.dismiss) private var dismiss
    init(viewModel: WorkReportViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                headerSection

                problemSection

                workPerformedSection

                additionalDetailsSection

                beforePhotosSection

                afterPhotosSection

                submissionSection
            }
            .padding()
        }
        .background(FieldOpsColors.background.ignoresSafeArea())
        .navigationTitle("Work Report")
        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                Button("Close") {
//                    dismiss()
//                }
//                .foregroundStyle(FieldOpsColors.primary)
//            }
//        }
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Complete your work report")
                .font(.title2.bold())
                .foregroundStyle(FieldOpsColors.textPrimary)

            Text("Document the problem, work performed, and photos from the job.")
                .font(.subheadline)
                .foregroundStyle(FieldOpsColors.textSecondary)

            HStack(spacing: 8) {
                Image(systemName: "briefcase.fill")
                    .foregroundStyle(FieldOpsColors.primary)

                Text(viewModel.job.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(FieldOpsColors.textPrimary)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    // MARK: - Problem

    private var problemSection: some View {
        formSection(title: "Problem Description", required: true) {
            TextField(
                "Describe the reported problem...",
                text: $viewModel.problem,
                axis: .vertical
            )
            .lineLimit(3...5)
            .reportTextFieldStyle()
          
        }
    }

    // MARK: - Work Performed

    private var workPerformedSection: some View {
        formSection(title: "Work Performed", required: true) {
            TextField(
                "Describe the work you completed...",
                text: $viewModel.workPerformed,
                axis: .vertical
            )
            .lineLimit(3...5)
            .reportTextFieldStyle()
        }
    }

    // MARK: - Additional Details

    private var additionalDetailsSection: some View {
        VStack(alignment: .leading, spacing: 16) {

            formSection(title: "Parts Used", required: false) {
                TextField(
                    "Enter parts or materials used...",
                    text: $viewModel.partsUsed,
                    axis: .vertical
                )
                .lineLimit(2...4)
                .reportTextFieldStyle()
            }

            formSection(title: "Additional Notes", required: false) {
                TextField(
                    "Any additional information...",
                    text: $viewModel.notes,
                    axis: .vertical
                )
                .lineLimit(2...4)
                .reportTextFieldStyle()
            }
        }
    }

    // MARK: - Before Photos

    private var beforePhotosSection: some View {
        photoSection(
            title: "Before Photos",
            description: "Capture the condition before starting work.",
            items: $viewModel.beforePhotos
        )
    }

    // MARK: - After Photos

    private var afterPhotosSection: some View {
        photoSection(
            title: "After Photos",
            description: "Capture the result after completing work.",
            items: $viewModel.afterPhotos
        )
    }

    // MARK: - Photo Section

    private func photoSection(
        title: String,
        description: String,
        items: Binding<[PhotosPickerItem]>
    ) -> some View {

        formSection(title: title, required: false) {

            VStack(alignment: .leading, spacing: 12) {

                Text(description)
                    .font(.caption)
                    .foregroundStyle(FieldOpsColors.textSecondary)

                PhotosPicker(
                    selection: items,
                    maxSelectionCount: 5,
                    matching: .images
                )  {
                    Label("Add Photos", systemImage: "camera")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(FieldOpsColors.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(FieldOpsColors.lightOrange)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                }

                if !items.wrappedValue.isEmpty {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 10
                    ) {
                        ForEach(items.wrappedValue.indices,id: \.self) { index in
                            PhotoThumbnail(item: items.wrappedValue[index]) {
                                items.wrappedValue.remove(at: index)
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Submission

    private var submissionSection: some View {
        VStack(spacing: 12) {

            if let error = viewModel.errorMessage {
                feedbackMessage(error, isSuccess: false)
            }

            if let success = viewModel.successMessage {
                feedbackMessage(success, isSuccess: true)
            }

            Button {
                Task {
                    await viewModel.submitReport()
                }
            } label: {
                HStack(spacing: 10) {
                    if viewModel.isSubmitting {
                        ProgressView()
                            .tint(.white)
                    }

                    Text(
                        viewModel.isSubmitting
                        ? "Submitting..."
                        : "Submit Work Report"
                    )
                    .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .foregroundStyle(.white)
                .background(
                    viewModel.canSubmit
                    ? FieldOpsColors.primary
                    : FieldOpsColors.textSecondary
                )
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .disabled(!viewModel.canSubmit)
        }
    }

    // MARK: - Reusable Components

    private func formSection<Content: View>(
        title: String,
        required: Bool,
        @ViewBuilder content: () -> Content
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(FieldOpsColors.textPrimary)

                if required {
                    Text("*")
                        .foregroundStyle(FieldOpsColors.primary)
                }
            }

            content()
        }
    }
    
    private func feedbackMessage(
        _ message: String,
        isSuccess: Bool
    ) -> some View {

        HStack(alignment: .top, spacing: 10) {
            Image(systemName: isSuccess ? "checkmark.circle.fill" : "exclamationmark.circle.fill")

            Text(message)
                .font(.subheadline)

            Spacer()
        }
        .foregroundStyle(
            isSuccess ? FieldOpsColors.success : .red
        )
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            isSuccess
            ? FieldOpsColors.success.opacity(0.1)
            : Color.red.opacity(0.08)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

private extension View {
    func reportTextFieldStyle() -> some View {
        self
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(FieldOpsColors.border, lineWidth: 1)
            }
    }
}

#Preview {
    let job = Job(id: UUID(), customerId: UUID(), technicianId: UUID(), title: "Air Conditoner maintenance", description: "Inspect the AC unit, clean the filters, and check the cooling performance.", priority: .high, status: .assigned, scheduledAt: Date())
    
    WorkReportView(viewModel: WorkReportViewModel(job: job, submitWorkReportUseCase: AppDependencies.shared.makeSubmitWorkReportUseCase(), uploadJobPhotoUseCase: AppDependencies.shared.makeUploadJobPhotoUseCase()))
}
