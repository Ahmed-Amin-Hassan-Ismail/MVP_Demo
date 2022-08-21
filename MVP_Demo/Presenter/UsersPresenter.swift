//
//  UsersPresenter.swift
//  MVP_Demo
//
//  Created by Ahmed Amin on 21/08/2022.
//

import Foundation
import UIKit

protocol UsersPresenterDelegate: AnyObject {
    func presentUsers(users: [Users])
    func presentAlert(title: String, message: String)
    
}


class UsersPresenter {
    
    typealias PresenterDelegate = UsersPresenterDelegate & UIViewController
    
    private weak var delegate: UsersPresenterDelegate?
    
    public func setViewDelegate(delegate: PresenterDelegate ) {
        self.delegate = delegate
    }
}


//MARK: - Private Methods
extension UsersPresenter {
    
    private func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let users = try JSONDecoder().decode([Users].self, from: data)
                self?.delegate?.presentUsers(users: users)
                
            } catch {
                print("Error Location", error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
}
