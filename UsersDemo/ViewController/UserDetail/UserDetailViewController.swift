//
//  UserDetailViewController.swift
//  UsersDemo
//
//  Created by Ankit Jayaswal on 16/03/21.
//

import UIKit

class UserDetailViewController: UIViewController {

    var userDetails: UserDetails?
    var isUserUpdated: (Bool) -> () = {_ in }
    
    private lazy var userDetailViewModel = UserDetailViewModel()

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNoTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.userDetailViewModel.userDetails = self.userDetails
    }

    func setupUI() {
        self.title = "\(userDetails?.userFirstName ?? "") \(userDetails?.userLastName ?? "")"
        self.firstNameTextField.text = userDetails?.userFirstName
        self.lastNameTextField.text = userDetails?.userLastName
        self.phoneNoTextField.text = userDetails?.userPhoneNo
    }

    @IBAction func actionUpdateButton(_ sender: Any) {
        // Assign alert "OK" button action after update
        self.userDetailViewModel.alertOKAction = self.alertOKAction(_:)
        
        // Present alert on user update completion
        self.userDetailViewModel.userUpdateCompletion = self.presentUserUpdateAlert(_:)
        
        // Update user's information in core-data
        self.userDetailViewModel.updateUser(firstName: firstNameTextField.text, lastName: lastNameTextField.text, phoneNo: phoneNoTextField.text)
    }

    func alertOKAction(_ alertAction: UIAlertAction) {
        self.isUserUpdated(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func presentUserUpdateAlert(_ alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - TextField delegate
extension UIViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
