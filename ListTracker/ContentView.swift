//
//  ContentView.swift
//  ListTracker
//
//  Created by Arman on 24/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var lists: [ListModel]
    
    @State private var isAlertShowing: Bool = false
  
    
    @State private var title: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(lists){ list in
                    Text(list.title)
                        .swipeActions {
                            Button("Delete", role: .destructive){
                                modelContext.delete(list)
                            }
                        }
                    
                }
            }
            .navigationTitle("List Tracker")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAlertShowing.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
                
            }
            .alert("Create a new Item", isPresented: $isAlertShowing){
                TextField("Enter Item", text: $title)
                Button{
                    guard !title.isEmpty else {
                        return
                    }
                    
                    modelContext.insert(ListModel(title: title))
                    title = ""
                } label: {
                    Text("Save")
                }
            }
            .overlay {
                if lists.isEmpty {
                    ContentUnavailableView("My Listing", systemImage: "heart.circle", description: Text("No Listing Added Yet"))
                }
            }
        }
    }
}

#Preview("List with sample data") {
    let container = try! ModelContainer(for: ListModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    container.mainContext.insert(ListModel(title: "Mastering swiftData"))
    container.mainContext.insert(ListModel(title: "Buy a new phone"))
    container.mainContext.insert(ListModel(title: "Everything is okay"))
    
    return ContentView()
        .modelContainer(container)
       
}


#Preview("Empty List") {
    ContentView()
        .modelContainer(for: ListModel.self, inMemory: true)
}
