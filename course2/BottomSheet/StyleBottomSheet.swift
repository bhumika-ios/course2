//
//  StyleBottomSheet.swift
//  course2
//
//  Created by Bhumika Patel on 05/08/23.
//

import SwiftUI
struct StyleBottomSheet: View {
    let style_tag: [String]
    @Binding var selectedStyle: String
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("Select Style")
                .font(.headline)
                .padding(.top, 16)

            ScrollView {
                ForEach(style_tag, id: \.self) { style in
                    Button(action: {
                        selectedStyle = style
                        isPresented = false
                    }) {
                        Text(style)
                            .foregroundColor(selectedStyle == style ? .blue : .primary)
                            .padding(.vertical, 8)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}
