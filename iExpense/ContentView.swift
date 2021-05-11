//
//  ContentView.swift
//  iExpense
//
//  Created by Terry Thrasher on 2021-05-04.
//
//  BUGS:
//      1. The first time our non-integer alert is shown, it dismisses itself immediately.
//      2. If the non-integer alert is shown, touching the Save button will save the result but not dismiss the AddView.

import SwiftUI

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}

struct textStyle: ViewModifier {
    var amount: Int
    
    func body(content: Content) -> some View {
        if amount < 10 {
            return content.foregroundColor(.black)
        }
        else if amount < 100 {
            return content.foregroundColor(.blue)
        }
        else {
            return content.foregroundColor(.red)
        }
    }
}

struct ContentView: View {
    @State private var showingAddExpense = false
    
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text("$\(item.amount)")
                            .modifier(textStyle(amount: item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        self.showingAddExpense = true
                    }) {
                        Image(systemName: "plus")
                    }
            )
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
