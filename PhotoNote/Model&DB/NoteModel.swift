//
//  NoteModel.swift
//  PhotoNote
//
//  Created by Maks Winters on 26.01.2024.
//

import Foundation
import UIKit
import SwiftUI

class NoteModel: Identifiable, Comparable, Hashable {
    static func < (lhs: NoteModel, rhs: NoteModel) -> Bool {
        lhs.title < rhs.title
    }
    
    static func == (lhs: NoteModel, rhs: NoteModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: Int64 = 0
    var photo: Data = Data()
    var title: String = ""
    
    var swiftUIImage: Image {
        let uiImage = UIImage(data: photo) ?? UIImage()
        return Image(uiImage: uiImage)
    }
}
