//
//  CurriculumBottomSheet.swift
//  course2
//
//  Created by Bhumika Patel on 05/08/23.
//


import SwiftUI
struct CurriculumBottomSheet: View {
    let curriculum_tags: [String]?
    @Binding var selectedCurriculum: String
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("Select Curriculum")
                .font(.headline)
                .padding(.top, 16)

            ScrollView {
                ForEach(curriculum_tags!, id: \.self) { curriculum in
                    Button(action: {
                        selectedCurriculum = curriculum
                        isPresented = false
                    }) {
                        Text(curriculum)
                            .foregroundColor(selectedCurriculum == curriculum ? .blue : .primary)
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
