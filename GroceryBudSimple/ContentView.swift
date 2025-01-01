//
//  ContentView.swift
//  GroceryBudSimple
//
//  Created by Adam Buryšek on 22.06.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var isClearAlertShown = false
    @FocusState private var focusedItemID: PersistentIdentifier?

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    @Bindable var item = item
                    HStack {
                        Button(action: {
                            toggleBuy(item: item)
                        }) {
                            Image(systemName: item.isBuyed ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(item.isBuyed ? .green : .gray)
                                .imageScale(.large)
                        }
                        .padding(.trailing, 10.0)
                        TextField("New Item", text: $item.name)
                            .focused($focusedItemID, equals: item.id)
                            .strikethrough(item.isBuyed ? true : false, color: .gray)
                            .foregroundColor(item.isBuyed ? .gray : .primary)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .alert(isPresented: $isClearAlertShown) {
                Alert(
                    title: Text("Do you want clear all items?"),
                    primaryButton: Alert.Button.destructive(Text("Clear all items"), action: {
                        clearAll()
                    }),
                    secondaryButton: Alert.Button.cancel()
                )
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isClearAlertShown.toggle()
                    }) {
                        Label("Clear All", systemImage: "trash.fill")
                    }
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date(), name: "", isBuyed: false)
            modelContext.insert(newItem)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            focusedItemID = newItem.id
                        }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    private func toggleBuy(item: Item) {
        item.isBuyed.toggle()
    }
    
    private func clearAll() {
        withAnimation {
            for item in items {
                modelContext.delete(item)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
