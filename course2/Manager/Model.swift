//
//  Model.swift
//  course2
//
//  Created by Bhumika Patel on 04/08/23.
//

import SwiftUI

import Foundation


struct Content: Codable {
    let record: Record
}

struct Record: Codable {
    let result: Result
}

struct Result: Codable {
    let index: [Course]
    let collections: Collections
}

struct Course: Codable, Identifiable {
    let id: Int
    let downloadid: Int
    let cdDownloads: Int?
    let title: String
    let educator: String
    let skill_tags: [String]?
    let style_tags: [String]
    let curriculum_tags: [String]?
    let series_tags: [String]?
    let owned: Int
    // Add other properties as needed...
    var imageURL: URL? {
            // Replace "{course_id}" with the actual course_id from the JSON data
            URL(string: "https://d2xkd1fof6iiv9.cloudfront.net/images/courses/\(id)/169_820.jpg")
        }
}
struct Collections: Codable {
    let smart: [Smart]
    
}
struct Smart: Codable, Identifiable {
    let id, label, smart: String
    let courses: [Int]
    let isDefault, isArchive: Int
    let description: String

}
enum SkillTag: String, Codable, Hashable {
    case advanced = "Advanced"
    case beginner = "Beginner"
    case empty = ""
    case intermediate = "Intermediate"
    case lateBeginner = "Late Beginner"
    case lateIntermediate = "Late Intermediate"
}
enum StyleTag: String, Codable {
    case blues = "Blues"
    case blueRock = "Blue-Rock"
   
}
