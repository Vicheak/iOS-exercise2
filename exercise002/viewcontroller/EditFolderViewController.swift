//
//  EditFolderViewController.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class EditFolderViewController: TemplateViewController {
    
    var folder: Folder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit Folder"
    
        titleTextField.text = folder.name
        detailTextView.text = folder.detail
    }
    
    @objc override func saveButtonTapped(sender: UIButton){
        let title = titleTextField.text ?? ""
        let detail = detailTextView.text ?? ""
        
        let folder = Folder(id: self.folder.id, name: title, detail: detail, notes: self.folder.notes)
        
        if DataValidation.validate(target: self, title: title, detail: detail){
            let alertController = UIAlertController(title: "Success", message: "A folder has been edited!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let self = self else { return }
                navigationController?.popViewController(animated: true)
            }
            NotificationCenter.default.post(name: NSNotification.Name.editFolder, object: folder)
            alertController.addAction(alertAction)
            present(alertController, animated: true)
        }
    }
    
}
