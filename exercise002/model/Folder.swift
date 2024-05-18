//
//  Folder.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import Foundation

struct Folder {
    
    var id: UUID
    var folderName: String
    var folderDetail: String
    var notes: [Note]
    
    init(id: UUID, folderName: String, folderDetail: String, notes: [Note]) {
        self.id = id
        self.folderName = folderName
        self.folderDetail = folderDetail
        self.notes = notes
    }
    
    init(folderName: String, folderDetail: String, notes: [Note]) {
        self.id = UUID()
        self.folderName = folderName
        self.folderDetail = folderDetail
        self.notes = notes
    }
    
}
