//
//  CourseRow.swift
//  course2
//
//  Created by Bhumika Patel on 05/08/23.
//
import SwiftUI
struct CourseRow: View {
    let course: Course

    var body: some View {
        VStack {
            if let imageURL = course.imageURL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                        .frame(width: 80, height: 80)
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            }

            Text(course.title)
                .font(.subheadline)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
        }
        .frame(width: 100)
    }
}
