//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Tarun on 23/06/26.
//

import SwiftData
import SwiftUI

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        .modelContainer(for: Student.self)
        .modelContainer(for: Book.self)
    }
}
