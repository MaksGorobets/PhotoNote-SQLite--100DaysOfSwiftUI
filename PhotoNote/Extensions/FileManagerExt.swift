//
//  FileManagerExt.swift
//  PhotoNote
//
//  Created by Maks Winters on 26.01.2024.
//

import Foundation

extension FileManager {
    static func getDocumentsDirectory() -> URL {
        do {
            let paths = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            return paths
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
