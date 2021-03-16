//
//  Users.swift
//  UsersDemo
//
//  Created by Ankit Jayaswal on 16/03/21.
//

import Foundation

// MARK: - UserList
class UserList: Codable {
    let status: String
    let data: [UserDetails]
}

// MARK: - UserDetails
class UserDetails: Codable {
    var id: Int?
    var userFirstName: String
    var userLastName: String
    var userPhoneNo: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userFirstName = "user_first_name"
        case userLastName = "user_last_name"
        case userPhoneNo = "user_phone_no"
    }
}
