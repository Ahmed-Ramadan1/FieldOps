//
//  OnboardingView.swift
//  FieldOps
//
//  Created by Ahmed on 16/10/2026.
//

import SwiftUI

struct OnboardingView: View {
    let onFinished: () -> Void

    @State private var currentPage = 0

    private let pages: [OnboardingPage] = [
        OnboardingPage(
            symbol: "calendar.badge.clock",
            title: "Your workday, organized.",
            description: "See your assigned jobs, schedules, and priorities in one clear view."
        ),
        OnboardingPage(
            symbol: "arrow.trianglehead.2.clockwise.rotate.90",
            title: "Every job, one step at a time.",
            description: "Track your progress from heading to the customer to completing the work."
        ),
        OnboardingPage(
            symbol: "camera.badge.ellipsis",
            title: "Document work with confidence.",
            description: "Record your work, capture photos, and keep every service report organized."
        )
    ]

    private var isLastPage: Bool {
        currentPage == pages.count - 1
    }

    var body: some View {
        VStack(spacing: 0) {
            // Skip
            HStack {
                Spacer()

                Button("Skip") {
                    onFinished()
                }
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
            }
            .padding(.top, 16)

            Spacer()

            // Current page
            VStack(spacing: 28) {
                ZStack {
                    RoundedRectangle(cornerRadius: 36)
                        .fill(Color.orange.opacity(0.10))
                        .frame(width: 240, height: 240)

                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color.orange.opacity(0.16))
                        .frame(width: 180, height: 180)
                        .rotationEffect(.degrees(-8))

                    Image(systemName: pages[currentPage].symbol)
                        .font(.system(size: 68, weight: .medium))
                        .foregroundStyle(Color.orange)
                        .frame(width: 150, height: 150)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .shadow(
                            color: .black.opacity(0.06),
                            radius: 20,
                            x: 0,
                            y: 10
                        )
                }
                .frame(height: 260)

                VStack(spacing: 14) {
                    Text(pages[currentPage].title)
                        .font(.system(size: 29, weight: .bold))
                        .foregroundStyle(Color.primary)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(pages[currentPage].description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(5)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: 320)
                }
                .padding(.horizontal, 12)
            }
            .id(currentPage)
            .transition(.opacity.combined(with: .move(edge: .trailing)))

            Spacer()

            // Page indicator
            HStack(spacing: 8) {
                ForEach(pages.indices, id: \.self) { index in
                    Capsule()
                        .fill(
                            index == currentPage
                            ? Color.orange
                            : Color.orange.opacity(0.20)
                        )
                        .frame(
                            width: index == currentPage ? 28 : 8,
                            height: 8
                        )
                }
            }
            .padding(.bottom, 28)

            // Continue / finish
            Button {
                if isLastPage {
                    onFinished()
                } else {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        currentPage += 1
                    }
                }
            } label: {
                HStack(spacing: 10) {
                    Text(isLastPage ? "Get Started" : "Continue")

                    Image(
                        systemName: isLastPage
                        ? "checkmark"
                        : "arrow.right"
                    )
                }
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
            .padding(.bottom, 24)
        }
        .padding(.horizontal, 24)
        .background(Color(.systemGroupedBackground))
    }
}

private struct OnboardingPage {
    let symbol: String
    let title: String
    let description: String
}


#Preview {
    OnboardingView(onFinished: { print("something")})
}
