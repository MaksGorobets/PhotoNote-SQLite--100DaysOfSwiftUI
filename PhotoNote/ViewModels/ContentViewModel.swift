//
//  ContentViewModel.swift
//  PhotoNote
//
//  Created by Maks Winters on 26.01.2024.
//

import Foundation
import SwiftUI

@Observable
class ContentViewModel {
    let dbManager = DBManager()
    var path = NavigationPath()
    
    var isShowingSheet = false
    
    var notesModels: [NoteModel] = []
    
    
    func loadNotes() {
        notesModels = dbManager.getNotes().sorted()
        print(notesModels.count)
    }
    
    func removeRows(at offsets: IndexSet) {
        for offset in offsets {
            let note = notesModels[offset]
            dbManager.deleteNote(idValue: note.id)
        }
    }
}
