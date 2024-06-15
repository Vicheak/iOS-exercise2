//
//  KeyboardUtil.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit
import SnapKit

class KeyboardUtil {
    
    var viewController: UIViewController!
    var view: UIView!
    var bottomConstraint: Constraint!
    
    init(viewController: UIViewController!, view: UIView!, bottomConstraint: Constraint!) {
        self.viewController = viewController
        self.view = view
        self.bottomConstraint = bottomConstraint
    }
    
    open func keyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func showKeyboard(notification: Notification){
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        bottomConstraint.update(offset: keyboardFrame.height * (-1))
        view.layoutIfNeeded()
    }
    
    @objc func hideKeyboard(){
        bottomConstraint.update(offset: 0)
        view.layoutIfNeeded()
    }
    
}
