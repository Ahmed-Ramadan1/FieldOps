//
//  PhotoThumbnail.swift
//  FieldOps
//
//  Created by Ahmed on 15/11/2026.
//

import SwiftUI
import PhotosUI

struct PhotoThumbnail: View {
    
    let item: PhotosPickerItem
    let onRemove: () -> Void

    @State private var image: UIImage?

    var body: some View {
        ZStack(alignment: .topTrailing) {

            Group {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Rectangle()
                        .fill(FieldOpsColors.border)
                        .overlay {
                            ProgressView()
                        }
                }
            }
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title3)
                    .foregroundStyle(.white, .black.opacity(0.65))
            }
            .padding(5)
        }
        .task {
            guard image == nil else { return }

            if let data = try? await item.loadTransferable(type: Data.self) {
                image = UIImage(data: data)
            }
        }
    }
}

#Preview {
    PhotoThumbnail(item: PhotosPickerItem(itemIdentifier: "jjj"), onRemove: {})
}
