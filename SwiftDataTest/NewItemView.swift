//
//  NewItemView.swift
//  SwiftDataTest
//
//  Created by chii_magnus on 2025/3/5.
//

import SwiftUI
import SwiftData

struct NewItemView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var articles: String = ""
    @State private var note: String = ""
    @State private var tag: String = ""
    @State private var timestamp: Date = Date()
    
    var body: some View {
        Form {
            Section(header: Text("文章内容")) {
                TextField("输入文章内容", text: $articles, axis: .vertical)
                    .lineLimit(5...)
            }
            
            Section(header: Text("笔记")) {
                TextField("输入笔记", text: $note, axis: .vertical)
                    .lineLimit(3...)
            }
            
            Section(header: Text("标签")) {
                TextField("输入标签", text: $tag)
            }
            
            Section(header: Text("日期")) {
                DatePicker("选择日期", selection: $timestamp, displayedComponents: .date)
            }
            
            Section {
                Button(action: saveItem) {
                    Text("提交")
                        .frame(maxWidth: .infinity)
                }
                .disabled(articles.isEmpty || note.isEmpty || tag.isEmpty)
                .keyboardShortcut(.defaultAction)
            }
        }
        .formStyle(.grouped)
        .padding()
        .navigationTitle("新建记录")
    }
    
    private func saveItem() {
        let newItem = Item(
            articles: articles,
            note: note,
            tag: tag,
            timestamp: timestamp
        )
        modelContext.insert(newItem)
        dismiss()
    }
}

#Preview {
    NewItemView()
        .modelContainer(for: Item.self, inMemory: true)
}
