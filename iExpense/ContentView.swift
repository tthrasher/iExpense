//
//  ContentView.swift
//  iExpense
//
//  Created by Terry Thrasher on 2021-05-04.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Wob"
    @Published var lastName = "Jass"
}

struct ContentView: View {
    @ObservedObject var user = User()
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")
            
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            
            Button("Show sheet") {
                self.showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SecondView(name: "Terrold")
            }
        }
    }
}

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    var name: String
    
    var body: some View {
        Button("Dismiss") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
