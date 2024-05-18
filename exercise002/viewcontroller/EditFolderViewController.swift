//
//  EditFolderViewController.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class EditFolderViewController: FolderTemplateViewController {
    
    var folder: Folder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit Folder"
        
        titleTextField.text = folder.folderName
        detailTextView.text = folder.folderDetail
    }
    
    @objc override func saveButtonTapped(sender: UIButton){
        let title = titleTextField.text ?? ""
        let detail = detailTextView.text ?? ""
        
        let folder = Folder(id: self.folder.id, folderName: title, folderDetail: detail, notes: self.folder.notes)
        
        if NoteValidation.validate(target: self, title: title, detail: detail){
            let alertController = UIAlertController(title: "Success", message: "A folder has been edited!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let self = self else { return }
                navigationController?.popViewController(animated: true)
            }
            NotificationCenter.default.post(name: NSNotification.Name.folderEditData, object: folder)
            alertController.addAction(alertAction)
            present(alertController, animated: true)
        }
    }
    
}
