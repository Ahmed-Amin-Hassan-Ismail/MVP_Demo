//
//  ViewController.swift
//  MVP_Demo
//
//  Created by Ahmed Amin on 21/08/2022.
//

import UIKit

class UsersViewController: UIViewController {
    
    private let presenter = UsersPresenter()
    private var users = [Users]()
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Users"
        
        
        // Setup TableView
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        // Call Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getUsers()
    }
}


//MARK: - UItableView
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // ask presenter to handle the tap
        presenter.didTapUsers(user: users[indexPath.row])
    }
}

//MARK: - UsersDelegate
extension UsersViewController: UsersPresenterDelegate {
    
    func presentUsers(users: [Users]) {
        
        self.users = users
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
}

