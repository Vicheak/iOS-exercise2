//
//  CreateFolderViewController.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class CreateFolderViewController: TemplateViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create New Folder"
        titleTextField.placeholder = "Enter folder name"
        detailTextView.text = "Enter folder detaill"
    }
    
    @objc override func saveButtonTapped(sender: UIButton){
        let title = titleTextField.text ?? ""
        let detail = detailTextView.text ?? ""
        
        let folder = Folder(name: title, detail: detail, notes: [])
        
        if DataValidation.validate(target: self, title: title, detail: detail){
            NotificationCenter.default.post(name: NSNotification.Name.saveFolder, object: folder)
            navigationController?.popViewController(animated: true)
        }
    }
    
}

