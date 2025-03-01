//
//  Tubes_Motion2025App.swift
//  Tubes_Motion2025
//
//  Created by Jundi HD on 23/02/25.
//

import SwiftUI

@main
struct Tubes_Motion2025App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
