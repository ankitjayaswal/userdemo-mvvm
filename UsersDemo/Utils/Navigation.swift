//
//  Navigation.swift
//  UsersDemo
//
//  Created by Ankit Jayaswal on 17/03/21.
//

import UIKit

extension UINavigationController {
    
    func pushToUserDetail(_ userDetail: UserDetails?, isUserUpdated: @escaping (Bool) -> Void) {
        let vc = storyboard?.instantiateViewController(identifier: "user_detail_vc")
        guard let userDetailVC = vc as? UserDetailViewController else {
            print("error: unable to instantiate user-detail-vc.")
            return
        }
        
        userDetailVC.userDetails = userDetail
        userDetailVC.isUserUpdated = isUserUpdated
        self.pushViewController(userDetailVC, animated: true)
    }
    
}
