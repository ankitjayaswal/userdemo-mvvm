//
//  UserDetailViewModel.swift
//  UsersDemo
//
//  Created by Ankit Jayaswal on 16/03/21.
//

import UIKit

class UserDetailViewModel: NSObject {

    var userDetails: UserDetails?

    var alertOKAction: ((UIAlertAction) -> Void)? = nil
    
    var userUpdateCompletion: (UIAlertController) -> () = {_ in }

    override init() {
        super.init()

    }

    func updateUser(firstName: String?, lastName: String?, phoneNo: String?) {
        guard let userInfo = userDetails else { return }
        userInfo.userFirstName = firstName ?? ""
        userInfo.userLastName = lastName ?? ""
        userInfo.userPhoneNo = phoneNo ?? ""

        let success = DataManager.shared.updateUser(userInfo)
        self.showUserUpdateAlert(success)
    }
    
    func showUserUpdateAlert(_ success: Bool) {
        let title = success ? "Success" : "Error"
        let message = success ? "User updated successfully." : "Error in user update!"
        let alertAction = success ? self.alertOKAction : nil
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: alertAction))

        // inform UserDetailVC about user update completion
        // present alert on view-controller
        self.userUpdateCompletion(alert)
    }
}
