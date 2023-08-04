//
//  SearchBar.swift
//  course2
//
//  Created by Bhumika Patel on 04/08/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
            }
        }
    }
}

