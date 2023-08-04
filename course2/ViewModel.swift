//
//  ViewModel.swift
//  course2
//
//  Created by Bhumika Patel on 04/08/23.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var courses: [Course] = []
    @Published  var smart: [Smart] = []

    func fetchCourses() {
        let url = URL(string: "https://api.jsonbin.io/v3/b/6458ec108e4aa6225e98d54d")!
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let jsonData = try decoder.decode(Content.self, from: data)
                    DispatchQueue.main.async {
                        self.smart = jsonData.record.result.collections.smart
                        self.courses = jsonData.record.result.index
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    func availableStyleOptions() -> [StyleTag] {
           return [.blues, .blueRock] // Update with your actual style options
       }

       func availableSkillOptions() -> [SkillTag] {
           return [.beginner, .intermediate, .advanced] // Update with your actual skill options
       }
    func availableEducatorOptions() -> [String] {
           let educators = Set(courses.map { $0.educator })
           return Array(educators).sorted()
       }
}
