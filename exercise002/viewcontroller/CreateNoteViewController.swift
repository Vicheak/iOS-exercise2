//
//  CreateNoteViewControlleer.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class CreateNoteViewController: TemplateViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create New Note"
        titleTextField.placeholder = "Enter note title"
        detailTextView.text = "Enter note detaill"
    }
    
    @objc override func saveButtonTapped(sender: UIButton){
        let title = titleTextField.text ?? ""
        let detail = detailTextView.text ?? ""
        
        let note = Note(title: title, detail: detail)
        
        if DataValidation.validate(target: self, title: title, detail: detail){
            NotificationCenter.default.post(name: NSNotification.Name.saveNote, object: note)
            navigationController?.popViewController(animated: true)
        }
    }
    
}

