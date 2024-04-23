//
//  Child_Lock_PrototypeApp.swift
//  Child Lock Prototype
//
//  Created by Yevin Warnapura on 2024-04-23.
//

import SwiftUI

@main
struct Child_Lock_PrototypeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
