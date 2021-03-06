//
//  Student.swift
//  Companion
//
//  Created by Nazar NAUMENKO on 5/2/19.
//  Copyright © 2019 Nazar NAUMENKO. All rights reserved.
//

import Foundation



struct Campus: Codable {
    
    var name: String
    
}

struct Campus_users: Codable {
    var campus_id: Int
    var id: Int
    var is_primary: Int
    var user_id: Int
}

struct User: Codable {
    var id: Int
    var login: String
    var url: String
}




struct Skill: Codable {
    
    var level: Double
    var name: String
}

struct CursusUsers: Codable {
    var level: Double
    var skills: [Skill]
}

struct Project: Codable {
    var name: String
    var id: Int
    var parentId: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case parentId = "parent_id"
    }
}



struct ProjectUser: Codable {
    
    var finalMark: Int?
    var project: Project
    var status: String
    var validated: Bool?
    var cursusIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case finalMark = "final_mark"
        case project
        case status
        case validated = "validated?"
        case cursusIds = "cursus_ids"
    }
}

struct Student : Codable {
    var id: Int
    var email: String
    var login: String
    var firstName: String
    var lastName: String
    var url: String
    var phone: String?
    var displayName: String
    var imageURL: String
    var staff: Bool
    var correctionPoint: Int
    var poolMonth: String
    var poolYear: String
    var location: String?
    var wallet: Int
    
    var cursusUsers: [CursusUsers]
    var projectsUsers: [ProjectUser]
    var campus: [Campus]
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case login
        case firstName = "first_name"
        case lastName = "last_name"
        case url
        case phone
        case displayName = "displayname"
        case imageURL = "image_url"
        case staff = "staff?"
        case correctionPoint = "correction_point"
        case poolMonth = "pool_month"
        case poolYear = "pool_year"
        case location
        case wallet
        
        case cursusUsers = "cursus_users"
        case projectsUsers = "projects_users"
        case campus = "campus"
    }
}



