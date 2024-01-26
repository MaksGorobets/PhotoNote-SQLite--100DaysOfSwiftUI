//
//  DBManager.swift
//  PhotoNote
//
//  Created by Maks Winters on 26.01.2024.
//

import Foundation
import SQLite

class DBManager {
    
    private var db: Connection!
    
    private var notesTable: Table!
    
    private var id: Expression<Int64>!
    private var photo: Expression<Data>!
    private var title: Expression<String>!
    
    func addNote(photoData: Data, titleValue: String) {
        do {
            try db.run(notesTable.insert(photo <- photoData, title <- titleValue))
            print("Saved the note")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getNotes() -> [NoteModel] {
        
        var notes: [NoteModel] = []
        
        do {
            for note in try db.prepare(notesTable) {
                
                let newNoteModel = NoteModel()
                
                newNoteModel.id = note[id]
                newNoteModel.photo = note[photo]
                newNoteModel.title = note[title]
                
                notes.append(newNoteModel)
            }
        } catch {
            print(error)
        }
        
        return notes
    }
    
    func deleteNote(idValue: Int64) {
        do {
            let note = notesTable.filter( id == idValue)
            try db.run(note.delete())
            print("Removed")
        } catch {
            print(error)
        }
    }
    
    init() {
        do {
            
            let path = FileManager.getDocumentsDirectory()
            
            db = try Connection("\(path)/my_notes.sqlite3")
            
            notesTable = Table("notes")
            
            id = Expression<Int64>("id")
            photo = Expression<Data>("photo")
            title =  Expression<String>("title")
            
            if !UserDefaults.standard.bool(forKey: "is_db_created") {
                let createdTable = notesTable.create { table in
                    table.column(id, primaryKey: true)
                    table.column(photo)
                    table.column(title)
                }
                
                try db.run(createdTable)
                
                UserDefaults.standard.setValue(true, forKey: "is_db_created")
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
