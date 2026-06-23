//
//  Student.swift
//  BookWorm
//
//  Created by Tarun on 23/06/26.
//

import Foundation
import SwiftData //💥 swiftData asks the iphone to make some physical data.

@Model
class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
