//
//  NewNoteViewModel.swift
//  PhotoNote
//
//  Created by Maks Winters on 26.01.2024.
//

import Foundation
import SwiftUI
import PhotosUI

@Observable
class NewNoteViewModel {
    private let dbManager = DBManager()
    
    var photoData: Data?
    var photoImage: Image?
    
    var saved: () -> Void
    
    var pickerItem: PhotosPickerItem? { didSet {
        Task {
            await convertPickerItem()
        }
    }}
    var title: String = ""
    
    func addNote() {
        print("Starting to add a note")
        guard let unwData = photoData else { return }
        print("Photo data - OK")
        guard !title.isEmpty else { return }
        print("Title - OK")
        
        dbManager.addNote(photoData: unwData, titleValue: title)
        print("Calling the addNote function")
        saved()
    }
    
    private func convertPickerItem() async {
        guard (pickerItem != nil) else { return }
        do {
            let initialData = try await pickerItem?.loadTransferable(type: Data.self)
            photoData = UIImage(data: initialData!)?.jpeg(.lowest)
            let uiImage = UIImage(data: photoData!)
            photoImage = Image(uiImage: uiImage ?? UIImage())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    init(saved: @escaping () -> Void) {
        self.saved = saved
    }
}
