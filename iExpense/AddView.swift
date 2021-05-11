//
//  AddView.swift
//  iExpense
//
//  Created by Terry Thrasher on 2021-05-07.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showingAlert = false
    
    @ObservedObject var expenses: Expenses
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                } else {
                    showingAlert = true
                    print("Alert has been set to TRUE")
                }

                self.presentationMode.wrappedValue.dismiss()
            })
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text("Invalid amount"), message: Text("You have entered something that is not an integer."), dismissButton: .default(Text("OK")) {
                    print("Alert has been set to FALSE")
                })
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
