import SwiftUI
import SwiftData

@main
struct NewMapApp: App {
    var body: some Scene {
        WindowGroup {
            NewMap()
        }
        .modelContainer(for: LocalItems.self)
    }
}


//
//  NewMap
//
//  Created by Islombek Gofurov.
//
