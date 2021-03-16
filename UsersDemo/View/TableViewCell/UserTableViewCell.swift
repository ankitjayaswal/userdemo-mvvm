//
//  UserTableViewCell.swift
//  UsersDemo
//
//  Created by Ankit Jayaswal on 16/03/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!

    var userDetails: UserDetails? {
        didSet {
            firstNameLabel.text = userDetails?.userFirstName
            lastNameLabel.text = userDetails?.userLastName
            phoneNoLabel.text = userDetails?.userPhoneNo
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
