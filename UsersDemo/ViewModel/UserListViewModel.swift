//
//  UserListViewModel.swift
//  UsersDemo
//
//  Created by Ankit Jayaswal on 16/03/21.
//

import Foundation
import CoreData

class UserListViewModel : NSObject {
    
    private(set) var userListArray: [UserDetails]? {
        didSet {
            self.fetchUserList()
        }
    }
    
    var fetchUserList: (() -> ()) = {}
    
    override init() {
        super.init()

    }
    
    func getUserList() {
        // Fetch user from core-data
        var usersList: [UserDetails] = DataManager.shared.getUserList()
        
        // On app's first launch fetched list will be empty
        // Load it from JSON file and write it to core-data
        if usersList.isEmpty {
            
            if let users = JSONReader.shared.readFromJSONFile("users") {
                
                usersList = users
                
                // Write usersList to core-data for further use
                usersList.forEach { userDetail in
                    DataManager.shared.insertUser(userDetail)
                }
                
            }
            
        }
        
        // Assign fetched usersList to userListArray
        self.userListArray = usersList
    }
    
}
