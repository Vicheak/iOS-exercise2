//
//  LoginValidation.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class LoginValidation {
    
    static func validate(target viewController: UIViewController, username: String, password: String, message: String = "Username and password can't be empty!") -> Bool {
        let alertController = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .destructive)
        alertController.addAction(alertAction)
    
        if username.isEmpty || password.isEmpty {
            viewController.present(alertController, animated: true)
            return false
        }
        
        return true
    }
    
}
