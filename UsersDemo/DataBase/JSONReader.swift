//
//  JSONReader.swift
//  UsersDemo
//
//  Created by Ankit Jayaswal on 16/03/21.
//

import Foundation

class JSONReader: NSObject {
    
    static let shared = JSONReader()
    
    private override init() {
        
    }

    func fileURL(_ fileName: String) -> URL? {
        return Bundle.main.url(forResource: fileName, withExtension: "json")
    }
    
    func readFromJSONFile(_ fileName: String) -> [UserDetails]? {
        guard let file = fileURL(fileName) else {
            print("error: resource file \(fileName) does not exist.")
            return nil
        }
        
        guard let data = try? Data(contentsOf: file) else {
            print("error: there is no data in resorce file \(fileName).")
            return nil
        }

        do {
            let decoder = JSONDecoder()
            let userList = try decoder.decode(UserList.self, from: data)
            return userList.data
        } catch let err {
            print("error: \(err.localizedDescription)")
            return nil
        }
    }

}
