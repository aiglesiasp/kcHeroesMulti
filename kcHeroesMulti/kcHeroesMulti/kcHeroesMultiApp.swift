//
//  kcHeroesMultiApp.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 5/12/22.
//

import SwiftUI

@main
struct kcHeroesMultiApp: App {
    //let persistenceController = PersistenceController.shared
    @StateObject var rootViewModel = RootViewModel()

    var body: some Scene {
        WindowGroup {
            rootView()
                .environmentObject(rootViewModel)
           /* LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            */
        }
    }
}
