//
//  kcHeroesMultiApp.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 5/12/22.
//

import SwiftUI

@main
struct kcHeroesMultiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
