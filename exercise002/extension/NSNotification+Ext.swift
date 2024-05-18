//
//  NSNotification+Ext.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

extension NSNotification.Name {
    
    static let saveFolder = NSNotification.Name.init("saveFolder")
    static let editFolder = NSNotification.Name.init("editFolder")
    static let deleteFolder = NSNotification.Name.init("deleteFolder")
    static let saveNote = NSNotification.Name.init("saveNote")
    static let editNote = NSNotification.Name.init("editNote")
    static let deleteNote = NSNotification.Name.init("deleteNote")
    
}
