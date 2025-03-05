import SwiftUI
import SwiftData

struct EditItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var item: Item
    
    var body: some View {
        Form {
            Section(header: Text("文章内容")) {
                TextField("文章内容", text: $item.articles, axis: .vertical)
                    .lineLimit(5...)
            }
            
            Section(header: Text("笔记")) {
                TextField("笔记", text: $item.note, axis: .vertical)
                    .lineLimit(3...)
            }
            
            Section(header: Text("标签")) {
                TextField("标签", text: $item.tag)
            }
            
            Section(header: Text("日期")) {
                DatePicker("日期", selection: $item.timestamp, displayedComponents: .date)
            }
        }
        .formStyle(.grouped)
        .padding()
        .navigationTitle("编辑记录")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("取消") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("保存") {
                    dismiss()
                }
                .disabled(item.articles.isEmpty || item.note.isEmpty || item.tag.isEmpty)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Item.self, configurations: config)
    
    let item = Item(articles: "示例文章", note: "示例笔记", tag: "示例标签", timestamp: Date())
    
    return EditItemView(item: item)
        .modelContainer(container)
} 