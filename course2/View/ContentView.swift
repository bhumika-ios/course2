//
//  ContentView.swift
//  course2
//
//  Created by Bhumika Patel on 04/08/23.
//
import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
 
    var body: some View {
        NavigationView {
            List(viewModel.smart) { smart in
                HStack {
                    Text(smart.label)
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    NavigationLink(destination: CoursesListView(smart: smart, viewModel: viewModel)) {
                        Text("View All")
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(smart.courses, id: \.self) { courseID in
                            if let course = viewModel.courses.first(where: { $0.id == courseID }) {
                                CourseRow(course: course)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Courses")
        }
        .onAppear {
            viewModel.fetchCourses()
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

