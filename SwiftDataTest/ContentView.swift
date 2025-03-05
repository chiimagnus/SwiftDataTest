//
//  ContentView.swift
//  SwiftDataTest
//
//  Created by chii_magnus on 2025/3/5.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedSidebarItem: SidebarItem? = .welcome
    @EnvironmentObject private var navigationCoordinator: NavigationCoordinator
    
    enum SidebarItem: Hashable {
        case welcome
        case newItem
        case history
    }
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedSidebarItem) {
                Text("SwiftData教学项目")
                    .font(.headline)
                    .padding(.vertical, 8)
                
                Section("功能导航") {
                    NavigationLink(value: SidebarItem.newItem) {
                        Label("新建记录", systemImage: "plus.circle")
                    }
                    // .keyboardShortcut("n", modifiers: [.command, .shift])
                    
                    NavigationLink(value: SidebarItem.history) {
                        Label("历史记录", systemImage: "clock")
                    }
                    // .keyboardShortcut("c", modifiers: [.command, .shift])
                }
            }
            .navigationSplitViewColumnWidth(min: 200, ideal: 250)

        } detail: {
            switch navigationCoordinator.currentView {
            case .welcome:
                WelcomeView()
            case .newItem:
                NewItemView()
            case .history:
                HistoryView()
            }
        }
        .onChange(of: navigationCoordinator.currentView) { newValue in
            selectedSidebarItem = newValue
        }
    }
}

struct WelcomeView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "database")
                .font(.system(size: 60))
                .foregroundColor(.accentColor)
            
            Text("欢迎使用SwiftData教学项目")
                .font(.title)
                .bold()
            
            Text("这是一个演示SwiftData基本用法的示例项目")
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 12) {
                FeatureRow(icon: "plus.circle", title: "新建记录", description: "创建并保存新的数据记录")
                FeatureRow(icon: "clock", title: "历史记录", description: "查看所有已保存的记录")
            }
            .padding()
            .background(Color(NSColor.windowBackgroundColor))
            .cornerRadius(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.accentColor)
                .frame(width: 30)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

    
    
#Preview {
    ContentView()
}
