//
//  Child_Lock_PrototypeApp.swift
//  Child Lock Prototype
//
//  Created by Yevin Warnapura on 2024-04-23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Child_Lock_PrototypeApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            WelcomeUIView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
