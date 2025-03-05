//
//  HistoryView.swift
//  SwiftDataTest
//
//  Created by chii_magnus on 2025/3/5.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query private var items: [Item]
    @State private var searchText = ""
    @State private var selection = Set<Item>()
    @State private var itemToEdit: Item?
    
    @Environment(\.modelContext) private var modelContext
    
    var filteredItems: [Item] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter {
                $0.articles.localizedCaseInsensitiveContains(searchText) ||
                $0.note.localizedCaseInsensitiveContains(searchText) ||
                $0.tag.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        List(filteredItems, selection: $selection) { item in
            VStack(alignment: .leading, spacing: 8) {
                // 显示日期和标签
                HStack {
                    Text(item.timestamp.formatted(date: .numeric, time: .shortened))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(item.tag)
                        .font(.caption)
                        .padding(4)
                        .background(Color.accentColor.opacity(0.2))
                        .cornerRadius(4)
                }
                
                // 显示文章内容
                Text(item.articles)
                    .font(.body)
                    .lineLimit(2)
                
                // 显示笔记
                if !item.note.isEmpty {
                    Text(item.note)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            .padding(.vertical, 8)
            .contextMenu {
                Button("删除", role: .destructive) {
                    modelContext.delete(item)
                }
                
                Button("编辑") {
                    itemToEdit = item
                }
            }
            .overlay(
                selection.contains(item) ? Color.accentColor.opacity(0.1) : Color.clear
            )
        }
        .searchable(text: $searchText, prompt: "搜索记录")
        .navigationTitle("历史记录")
        .sheet(item: $itemToEdit) { item in
            NavigationStack {
                EditItemView(item: item)
            }
        }
    }
}

#Preview {
    HistoryView()
        .modelContainer(for: Item.self, inMemory: true)
}

