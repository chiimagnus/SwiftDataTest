//
//  ContentView.swift
//  SwiftDataTest
//
//  Created by chii_magnus on 2025/3/5.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showNewItem = false  // 添加状态变量控制 sheet 的显示
    @State private var showHistory = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("SwiftData数据库教学项目")
                    .font(.title)
                    .bold()
                Text("有两个功能：")
                Text("1.新建记录")
                Text("2.查看记录")
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showNewItem = true
                    }) {
                        Label("新建记录", systemImage: "plus")
                    }
                    .keyboardShortcut("n", modifiers:[])  // 添加键盘快捷键
                }
                
                ToolbarItem {
                    Button(action: {
                        showHistory = true
                    }) {
                        Label("历史记录", systemImage: "heart")
                    }
                    .keyboardShortcut("l", modifiers: [])
                }
            }
            .sheet(isPresented: $showNewItem) {
                NewItemView()
            }
            .sheet(isPresented: $showHistory) {
                HistoryView()
            }
        }
    }
}
    
    
#Preview {
    ContentView()
}
