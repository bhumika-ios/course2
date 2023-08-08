//
//  SkillBottomSheet.swift
//  course2
//
//  Created by Bhumika Patel on 05/08/23.
//

import SwiftUI

struct SkillBottomSheet: View {
    let skills: [String]
    @Binding var selectedSkill: String
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("Select Skill")
                .font(.headline)
                .padding(.top, 16)

            ScrollView {
                ForEach(skills, id: \.self) { skill in
                    Button(action: {
                        selectedSkill = skill
                        isPresented = false
                    }) {
                        Text(skill)
                            .foregroundColor(selectedSkill == skill ? .blue : .primary)
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
