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
                //  NavigationLink(destination: CourseDetailView(course: course)) {
                HStack{
                    Text(smart.label)
                        .font(.headline)
                        .fontWeight(.bold)
                 //   Spacer()
//                    NavigationLink(destination: ViewAllCoursesView(smart: smart), label:  Text("ViewAll"))
//                    NavigationLink(destination: ViewAllCoursesView(), label:{
//                        Text("ViewAll")
//                    })
//                    Button(action: {}, label: {
//                        Text("ViewAll")
//                    })
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
        
                }
                .onAppear {
                    viewModel.fetchCourses()
                }
          
    }
    
}

//struct CourseRow: View {
//    let smart: Smart
//
//    var body: some View {
//        HStack {
////            Image(uiImage: UIImage(contentsOfFile: course.imageURL!.path) ?? UIImage(systemName: "photo")!)
////                .resizable()
////                .frame(width: 60, height: 60)
////                .cornerRadius(8)
//            VStack(alignment: .leading) {
//                Text(smart.smart)
//                    .font(.headline)
//                Text(smart.label)
//                    .font(.subheadline)
//            }
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
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
struct CoursesListView: View {
    let smart: Smart
    @ObservedObject var viewModel = ContentViewModel()
    @State private var searchText = ""
    @State private var selectedFilter = "All"
    @State private var selectedEducator = "All Educators"
    @State private var isEducatorSheetPresented = false

    // ... other properties ...
    var filteredCourses: [Course] {
            var coursesToDisplay = viewModel.courses.filter { smart.courses.contains($0.id) }
    
            if selectedFilter != "All" {
                if selectedFilter == "Educator" {
                    if selectedFilter == "Educator" && selectedEducator != "All Educators" {
                            return coursesToDisplay.filter { $0.educator == selectedEducator }
                        }
                } else {
                    // Handle other filters here if needed
                }
            }
    
            if !searchText.isEmpty {
                coursesToDisplay = coursesToDisplay.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
            }
    
            return coursesToDisplay
        }
    var body: some View {
        ScrollView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(.horizontal)

                Picker(selection: $selectedFilter, label: Text("Filter")) {
                    // ... other filter options ...
                    Text("Educator").tag("Educator")
                    // ... other filter options ...
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.vertical, 8)

                if selectedFilter == "Educator" {
                    Button("Select Educator: \(selectedEducator)") {
                        isEducatorSheetPresented = true
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                }

                // ... other UI components ...

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                    ForEach(filteredCourses, id: \.id) { course in
                        CourseRow(course: course)
                    }
                }
            }
        }
        .navigationTitle(smart.label)
        .onAppear {
            viewModel.fetchCourses()
        }
        .sheet(isPresented: $isEducatorSheetPresented) {
            EducatorBottomSheet(educators: ["All Educators", "Mike Zito", "Frank Vignola", "Jeff McErlain","Brad Carlton","TrueFire","Mike Zito","Corey Congilio","Diego Figueiredo","Stu Hamm","Matt Schofield","Jay-P","Tommy Emmanuel","Jason Loughlin","Tim Lerch","Tim Pierce","Jimmy  Vivino","Tom Dempsey"], selectedEducator: $selectedEducator, isPresented: $isEducatorSheetPresented)
        }
    }
}


//struct CoursesListView: View {
//    let smart: Smart
//    @ObservedObject var viewModel = ContentViewModel()
//    @State private var searchText = ""
//    @State private var selectedFilter = "All"
//    @State private var selectedEducator = "All Educators"
//
//    var filteredCourses: [Course] {
//        var coursesToDisplay = viewModel.courses.filter { smart.courses.contains($0.id) }
//
//        if selectedFilter != "All" {
//            if selectedFilter == "Educator" {
//                if selectedEducator != "All Educators" {
//                    coursesToDisplay = coursesToDisplay.filter { course in
//                        return course.educator == selectedEducator
//                    }
//                }
//            } else {
//                // Handle other filters here if needed
//            }
//        }
//
//        if !searchText.isEmpty {
//            coursesToDisplay = coursesToDisplay.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
//        }
//
//        return coursesToDisplay
//    }
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                SearchBar(text: $searchText)
//                    .padding(.horizontal)
//
//                Picker(selection: $selectedFilter, label: Text("Filter")) {
//                    Text("All").tag("All")
//                    Text("Educator").tag("Educator")
//                    // Add other filter options here if needed
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding(.horizontal)
//                .padding(.vertical, 8)
//
//                if selectedFilter == "Educator" {
//                    Picker("Select Educator", selection: $selectedEducator) {
//                        Text("All Educators").tag("All Educators")
//                        Text("Educator 1").tag("Educator 1")
//                        Text("Educator 2").tag("Educator 2")
//                        // Add other educator options here
//                    }
//                    .pickerStyle(MenuPickerStyle())
//                    .padding(.horizontal)
//                    .padding(.bottom, 8)
//                }
//
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
//                    ForEach(filteredCourses, id: \.id) { course in
//                        CourseRow(course: course)
//                    }
//                }
//            }
//        }
//        .navigationTitle(smart.label)
//        .onAppear {
//            viewModel.fetchCourses()
//        }
//    }
//}
