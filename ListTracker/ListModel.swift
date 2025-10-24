//
//  ListModel.swift
//  ListTracker
//
//  Created by Arman on 24/10/25.
//

import Foundation
import SwiftData

@Model
class ListModel {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
