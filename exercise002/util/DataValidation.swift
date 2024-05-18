//
//  NoteValidation.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class DataValidation {
    
    static func validate(target viewController: UIViewController, title: String, detail: String, messages: [String] = [
        "Please enter title!",
        "Please enter detail!"
    ]) -> Bool {
        var alertController: UIAlertController
        let alertAction = UIAlertAction(title: "OK", style: .destructive)
        
        if title.isEmpty {
            alertController = UIAlertController(title: "Error", message: messages[0], preferredStyle: .alert)
            alertController.addAction(alertAction)
            
            viewController.present(alertController, animated: true)
            return false
        }
        
        if detail.isEmpty {
            alertController = UIAlertController(title: "Error", message: messages[1], preferredStyle: .alert)
            alertController.addAction(alertAction)
            
            viewController.present(alertController, animated: true)
            return false
        }
        
        return true
    }
    
}
