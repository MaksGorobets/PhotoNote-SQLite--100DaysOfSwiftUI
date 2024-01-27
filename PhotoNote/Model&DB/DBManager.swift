//
//  DBManager.swift
//  PhotoNote
//
//  Created by Maks Winters on 26.01.2024.
//
// https://adnan-tech.com/create-read-update-and-delete-from-sqlite-swift-swift-ui/
//
// https://www.youtube.com/watch?v=c4wLS9py1rU&t=768s
//

import Foundation
import SQLite

class DBManager {
    
    private var db: Connection!
    
    private var notesTable: Table!
    
    private var id: Expression<Int64>!
    private var photo: Expression<Data>!
    private var title: Expression<String>!
    private var longitude: Expression<Double>!
    private var latitude: Expression<Double>!
    
    func addNote(photoData: Data, titleValue: String, longitudeValue: Double, latitudeValue: Double) {
        do {
            try db.run(notesTable.insert(photo <- photoData, title <- titleValue, longitude <- longitudeValue, latitude <- latitudeValue))
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
                newNoteModel.longitude = note[longitude]
                newNoteModel.latitude = note[latitude]
                
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
            longitude = Expression<Double>("longitude")
            latitude = Expression<Double>("latitude")
            
            if !UserDefaults.standard.bool(forKey: "is_db_created") {
                let createdTable = notesTable.create { table in
                    table.column(id, primaryKey: true)
                    table.column(photo)
                    table.column(title)
                    table.column(longitude)
                    table.column(latitude)
                }
                
                try db.run(createdTable)
                
                UserDefaults.standard.setValue(true, forKey: "is_db_created")
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
