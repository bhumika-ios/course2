//
//  CoursesListView.swift
//  course2
//
//  Created by Bhumika Patel on 05/08/23.
//

import SwiftUI
struct CoursesListView: View {
    let smart: Smart
    @ObservedObject var viewModel = ContentViewModel()
    @State private var searchText = ""
    @State private var selectedFilter = "All"
    @State private var selectedEducator = "All Educators"
    @State private var isEducatorSheetPresented = false
    @State private var isSkillSheetPresented = false
    @State private var isStyleSheetPresented = false
    @State private var isCurriculumSheetPresented = false
    @State private var isSeriesSheetPresented = false
    @State private var selectedSkillOption = "All Skills"
    @State private var selectedStyleOption = "All Style"
    @State private var selectedCurriculumOption = "All Curriculum"
    @State private var selectedSeriesOption = "All Series"
    
    var filteredCourses: [Course] {
            var coursesToDisplay = viewModel.courses.filter { smart.courses.contains($0.id) }
    
            if selectedFilter != "All" {
                if selectedFilter == "Educator" {
                    if selectedFilter == "Educator" && selectedEducator != "All Educators" {
                            return coursesToDisplay.filter { $0.educator == selectedEducator }
                        }
                } else if  selectedFilter == "Skill" {
                    if selectedFilter == "Skill" && selectedSkillOption != "All Skills" {
                        coursesToDisplay = coursesToDisplay.filter { course in
                                       return course.skill_tags?.contains(selectedSkillOption) ?? false
                                   }
                    }
                }else if  selectedFilter == "Style" {
                    if selectedFilter == "Style" && selectedStyleOption != "All Style" {
                        coursesToDisplay = coursesToDisplay.filter { course in
                            return !(course.style_tags?.contains(selectedStyleOption) ?? false)
                        }
                    }
                }else if  selectedFilter == "Curriculum" {
                    if selectedFilter == "Curriculum" && selectedCurriculumOption != "All Curriculum" {
                        coursesToDisplay = coursesToDisplay.filter { course in
                            return !(course.curriculum_tags?.contains(selectedCurriculumOption) ?? false)
                        }
                    }
                }else if  selectedFilter == "Series" {
                    if selectedFilter == "Series" && selectedSeriesOption != "All Series" {
                        coursesToDisplay = coursesToDisplay.filter { course in
                            return !(course.series_tags?.contains(selectedSeriesOption) ?? true)
                        }
                    }
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
                   
                    Text("Educator").tag("Educator")
                    Text("Skill").tag("Skill")
                    Text("Style").tag("Style")
                    Text("Curriculum").tag("Curriculum")
                    Text("Series").tag("Series")
                    
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
                if selectedFilter == "Skill" {
                                    Button("Select Skill: \(selectedSkillOption)") {
                                        isSkillSheetPresented = true
                                    }
                                    .padding(.horizontal)
                                    .padding(.bottom, 8)
                                }
                if selectedFilter == "Style" {
                               Button("Select Style: \(selectedStyleOption)") {
                                   isStyleSheetPresented = true
                               }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                }
                if selectedFilter == "Curriculum" {
                               Button("Select Curriculum: \(selectedCurriculumOption)") {
                                   isCurriculumSheetPresented = true
                               }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                }
                if selectedFilter == "Series" {
                               Button("Select Series: \(selectedSeriesOption)") {
                                   isSeriesSheetPresented = true
                               }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                }

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
            EducatorBottomSheet(educators: ["All Educators", "Mike Zito", "Frank Vignola", "Jeff McErlain","Brad Carlton","TrueFire","Mike Zito","Corey Congilio","Diego Figueiredo","Stu Hamm","Matt Schofield","Jay-P","Tommy Emmanuel","Jason Loughlin","Tim Lerch","Tim Pierce","Jimmy  Vivino"], selectedEducator: $selectedEducator, isPresented: $isEducatorSheetPresented)
        }
        .sheet(isPresented: $isSkillSheetPresented) {
            SkillBottomSheet(skills: ["All Skill", "Intermediate", /*...*/], selectedSkill: $selectedSkillOption, isPresented: $isSkillSheetPresented)
            
        }
        .sheet(isPresented: $isStyleSheetPresented) {
            StyleBottomSheet(style_tag: ["All Style","Jazz",
                                         "Fingerstyle",
                                         "Latin",
                                         "World"], selectedStyle:  $selectedStyleOption, isPresented: $isStyleSheetPresented)
        }
        .sheet(isPresented: $isCurriculumSheetPresented) {
            CurriculumBottomSheet(curriculum_tags: ["All Curriculum","Rhythm",
                                                    "Chord Progressions",
                                                    "Comping",
                                                    "Licks","Left-Hand Techniques",
                                                    "Picking",
                                                    "Pentatonic",
                                                    "Right-Hand Techniques",
                                                    "Phrasing",
                                                    "Bending","Rhythm",
                                                    "Jamming",
                                                    "Chord Progressions",
                                                    "Strumming",
                                                    "Arrangement",
                                                    "Chord Substitution",], selectedCurriculum:  $selectedCurriculumOption, isPresented: $isCurriculumSheetPresented)
        }
        .sheet(isPresented: $isSeriesSheetPresented) {
            SeriesBottomSheet(series_tags: ["All Series","Licks You Must Know",
                                            "",
                                            "Fakebook",
                                            "Guitar Lab"], selectedSeries:  $selectedSeriesOption, isPresented: $isSeriesSheetPresented)
        }
    }
}
