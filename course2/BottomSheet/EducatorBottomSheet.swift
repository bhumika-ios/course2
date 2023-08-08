//
//  EducatorBottomSheet.swift
//  course2
//
//  Created by Bhumika Patel on 05/08/23.
//

import SwiftUI

struct EducatorBottomSheet: View {
    let educators: [String]
    @Binding var selectedEducator: String
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("Select Educator")
                .font(.headline)
                .padding(.top, 16)

            ScrollView {
                ForEach(educators, id: \.self) { educator in
                    Button(action: {
                        selectedEducator = educator
                        isPresented = false
                    }) {
                        Text(educator)
                            .foregroundColor(selectedEducator == educator ? .blue : .primary)
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
