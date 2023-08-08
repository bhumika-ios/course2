//
//  SeriesBottomSheet.swift
//  course2
//
//  Created by Bhumika Patel on 05/08/23.
//

import SwiftUI
struct SeriesBottomSheet: View {
    let series_tags: [String]
    @Binding var selectedSeries: String
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("Select Series")
                .font(.headline)
                .padding(.top, 16)

            ScrollView {
                ForEach(series_tags, id: \.self) { series in
                    Button(action: {
                        selectedSeries = series
                        isPresented = false
                    }) {
                        Text(series)
                            .foregroundColor(selectedSeries == series ? .blue : .primary)
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
