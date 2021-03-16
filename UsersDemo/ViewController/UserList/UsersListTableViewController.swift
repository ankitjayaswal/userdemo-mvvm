//
//  UsersListTableViewController.swift
//  UsersDemo
//
//  Created by Ankit Jayaswal on 16/03/21.
//

import UIKit

class UsersListTableViewController: UITableViewController {

    private lazy var userListViewModel = UserListViewModel()
    private var dataSource: UserListTableViewDataSource<UserTableViewCell, UserDetails>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        setupUIWithViewModel()
    }
    
    func refreshView(_ userUpdate: Bool) {
        self.tableView.reloadData()
    }

    func setupUIWithViewModel() {
        self.userListViewModel.fetchUserList = {
            self.updateDataSource()
        }
        self.userListViewModel.getUserList()
    }
    
    func updateDataSource(){
        let usersArray = self.userListViewModel.userListArray
        self.dataSource = UserListTableViewDataSource(cellIdentifier: "UserTableViewCell", items: usersArray, configureCell: { (cell, userDetails) in
            cell.userDetails = userDetails
        })
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }

}

// MARK: - Table view delegate
extension UsersListTableViewController {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushToUserDetail(self.userListViewModel.userListArray?[indexPath.row], isUserUpdated: refreshView(_:))
    }

}
