//
//  NSNotification+Ext.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

extension NSNotification.Name {
    
    static let saveData = NSNotification.Name.init("saveData")
    static let editData = NSNotification.Name.init("editData")
    static let deleteData = NSNotification.Name.init("deleteData")
    static let folderSaveData = NSNotification.Name.init("folderSaveData")
    static let folderEditData = NSNotification.Name.init("folderEditData")
    static let folderDeleteData = NSNotification.Name.init("folderDeleteData")
    
}
