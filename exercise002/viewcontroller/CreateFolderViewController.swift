//
//  CreateFolderViewController.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class CreateFolderViewController: FolderTemplateViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create New Folder"
    }
    
    @objc override func saveButtonTapped(sender: UIButton){
        let title = titleTextField.text ?? ""
        let detail = detailTextView.text ?? ""
        
        let folder = Folder(folderName: title, folderDetail: detail, notes: [])
        
        if NoteValidation.validate(target: self, title: title, detail: detail){
//            let alertController = UIAlertController(title: "Success", message: "A new note has been added!", preferredStyle: .alert)
//            let alertAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
//                guard let self = self else { return }
//                titleTextField.text = ""
//                detailTextView.text = ""
//                navigationController?.popViewController(animated: true)
//            }
            NotificationCenter.default.post(name: NSNotification.Name.folderSaveData, object: folder)
//            alertController.addAction(alertAction)
//            present(alertController, animated: true)
            navigationController?.popViewController(animated: true)
        }
    }
    
}

