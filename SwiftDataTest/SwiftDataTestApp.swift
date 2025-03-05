//
//  SwiftDataTestApp.swift
//  SwiftDataTest
//
//  Created by chii_magnus on 2025/3/5.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataTestApp: App {
    @StateObject private var navigationCoordinator = NavigationCoordinator()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationCoordinator)
        }
        .modelContainer(sharedModelContainer)
        .commands {
            CommandGroup(after: .newItem) {
                Button("新建记录") {
                    navigationCoordinator.navigate(to: .newItem)
                }
                .keyboardShortcut("n", modifiers: [.command, .shift])
                
                Button("历史记录") {
                    navigationCoordinator.navigate(to: .history)
                }
                .keyboardShortcut("c", modifiers: [.command, .shift])
            }
        }
    }
}

class NavigationCoordinator: ObservableObject {
    @Published var currentView: ContentView.SidebarItem = .welcome
    
    func navigate(to view: ContentView.SidebarItem) {
        currentView = view
    }
}
