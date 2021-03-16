//
//  DataManager.swift
//  UsersDemo
//
//  Created by Ankit Jayaswal on 16/03/21.
//

import Foundation
import UIKit
import CoreData

class DataManager: NSObject {
    
    static let shared = DataManager()
    
    private override init() {
        
    }
    
    lazy var viewContext: NSManagedObjectContext? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }()
    
    func getUserList() -> [UserDetails] {
        guard let managedContext = viewContext else { return [] }
       
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
      
        var usersDetailModelArray: [UserDetails] = []
        do {
            let usersObjects = try managedContext.fetch(fetchRequest)
            usersDetailModelArray = self.getUserDetailModelArray(arr: usersObjects)
        } catch let error as NSError {
            print("error: usersList retrieving failed: \(error), \(error.userInfo)")
        }
       
        return usersDetailModelArray
    }
    
    func updateUser(_ userData: UserDetails) -> Bool {
        guard let managedContext = viewContext else { return false }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        let predicate = NSPredicate(format: "id == %d", userData.id!)
        fetchRequest.predicate = predicate

        if let user = try? managedContext.fetch(fetchRequest).first {
            user.setValue(userData.userFirstName, forKeyPath: "firstName")
            user.setValue(userData.userLastName, forKeyPath: "lastName")
            user.setValue(userData.userPhoneNo, forKeyPath: "phoneNo")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("error: user update failed: \(error), \(error.userInfo)")
            return false
        }
        return true
    }
    
    func insertUser(_ userData: UserDetails) {
        guard let managedContext = viewContext else { return }
        
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!

        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        user.setValue(userData.id ?? self.getIdForNewUser(managedContext) , forKey: "id")
        user.setValue(userData.userFirstName, forKeyPath: "firstName")
        user.setValue(userData.userLastName, forKeyPath: "lastName")
        user.setValue(userData.userPhoneNo, forKeyPath: "phoneNo")
        
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("error: user insert failed: \(error), \(error.userInfo)")
        }

    }
    
}

extension DataManager {
    
    fileprivate func getUserDetailModelArray(arr: [NSManagedObject]) -> [UserDetails] {
        var userDetailArray: [UserDetails] = []
        arr.forEach { managedObject in
            if let userInfo = self.convertToUserData(object: managedObject) {
                userDetailArray.append(userInfo)
            }
        }
        return userDetailArray
    }
    
    fileprivate func convertToUserData(object: NSManagedObject) -> UserDetails? {
        let dict: [String: Codable] = [ "id": object.value(forKeyPath: "id") as? Int,
                                        "user_first_name": object.value(forKeyPath: "firstName") as? String,
                                        "user_last_name": object.value(forKeyPath: "lastName") as? String,
                                        "user_phone_no": object.value(forKeyPath: "phoneNo") as? String ];
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let userData = try JSONDecoder().decode(UserDetails.self, from: jsonData)
            return userData
        } catch let err {
            print("error: not able to convert to UserDetail object.")
            print("\(err.localizedDescription)")
            return nil
        }
    }

    fileprivate func getIdForNewUser(_ viewContext: NSManagedObjectContext) -> Int {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]

        // minimum value for id field
        var userId = 1
        if let lastUserId = try? viewContext.fetch(fetchRequest).first?.value(forKey: "id") as? Int {
            userId = Int(lastUserId) + 1
        }
        return userId
    }
    
}
