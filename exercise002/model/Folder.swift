//
//  Folder.swift
//  exercise002
//
//  Created by @suonvicheakdev on 18/5/24.
//

import Foundation

struct Folder {
    
    var id: UUID
    var name: String
    var detail: String
    var notes: [Note]
    
    init(id: UUID, name: String, detail: String, notes: [Note]) {
        self.id = id
        self.name = name
        self.detail = detail
        self.notes = notes
    }
    
    init(name: String, detail: String, notes: [Note]) {
        self.id = UUID()
        self.name = name
        self.detail = detail
        self.notes = notes
    }
    
}
