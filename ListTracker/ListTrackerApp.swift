//
//  ListTrackerApp.swift
//  ListTracker
//
//  Created by Arman on 24/10/25.
//

import SwiftUI
import SwiftData

@main
struct ListTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ListModel.self)
        }
    }
}
