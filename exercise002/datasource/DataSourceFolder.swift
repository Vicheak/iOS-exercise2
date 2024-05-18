//
//  DataSourceFolder.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class DataSourceFolder {
    
    var folders: [Folder]!
    
    init() {
        self.folders = [
            Folder(folderName: "f001", folderDetail: "detail", notes: [
                Note(title: "title", detail: "detail"),
                Note(title: "title", detail: "detail"),
                Note(title: "title", detail: "detail"),
                Note(title: "title", detail: "detail"),
                Note(title: "title", detail: "detail"),
                Note(title: "title", detail: "detail"),
                Note(title: "title", detail: "detail")
            ])
        ]
        
        dataSourceNotificationFolder()
        dataSourceNotification()
    }
    
    open func dataSourceNotificationFolder(){
        NotificationCenter.default.addObserver(self, selector: #selector(createNewFolder), name: NSNotification.Name.folderSaveData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editFolder), name: NSNotification.Name.folderEditData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteFolder), name: NSNotification.Name.folderDeleteData, object: nil)
    }
    
    @objc func createNewFolder(notification: Notification){
        guard let folder = notification.object as? Folder else { return }
        self.folders.append(folder)
    }
    
    @objc func editFolder(notification: Notification){
        guard let folder = notification.object as? Folder else { return }
        if let index = folders.firstIndex(where: { n in
            n.id == folder.id
        }){
            folders[index].folderName = folder.folderName
            folders[index].folderDetail = folder.folderDetail
        }
    }
    
    @objc func deleteFolder(notification: Notification){
        guard let indexPath = notification.object as? IndexPath else { return }
        self.folders.remove(at: indexPath.row)
    }
    
    open func dataSourceNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(createNewNote), name: NSNotification.Name.saveData, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(editNote), name: NSNotification.Name.editData, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(deleteNote), name: NSNotification.Name.deleteData, object: nil)
    }
    
    @objc func createNewNote(notification: Notification){
        guard let folderId: UUID = notification.object as? UUID else { return }
        guard let note = notification.userInfo?["note"] as? Note else { return }
        print(folderId)
        print(note)
        if let index = folders.firstIndex(where: { n in
            n.id == folderId
        }){
            folders[index].notes.append(note)
        }
    }
    
//    @objc func editNote(notification: Notification){
//        guard let note = notification.object as? Note else { return }
//        if let index = notes.firstIndex(where: { n in
//            n.id == note.id
//        }){
//            notes[index].title = note.title
//            notes[index].detail = note.detail
//        }
//    }
//    
//    @objc func deleteNote(notification: Notification){
//        guard let indexPath = notification.object as? IndexPath else { return }
//        self.notes.remove(at: indexPath.row)
//    }
    
}
