//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Terry Thrasher on 2021-05-06.
//

import Foundation
import SwiftUI

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
