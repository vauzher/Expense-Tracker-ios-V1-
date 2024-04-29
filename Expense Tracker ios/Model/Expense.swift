//
//  Expense.swift
//  Expense Tracker ios
//
//  Created by Hama Nashwan on 15/12/2022.
//

import SwiftUI
import RealmSwift

// Model expense or data
struct Expense: Identifiable, Hashable {
    var id: String
    var remark: String
    var amount: Double
    var date: Date
    var type: ExpenseType
    var color: String
}

enum ExpenseType: String {
    case income = "Income"
    case expense = "Expenses"
    case all = "ALL"
}

// Function to fetch expenses from Realm and return an array of Expense objects
func fetchExpensesFromRealm() -> [Expense] {
    let realm = try! Realm()
    let expenseResults = realm.objects(ExpenseRealm.self)
    var expenses: [Expense] = []
    for expense in expenseResults {
        let expenseType = ExpenseType(rawValue: expense.type) ?? .all
        let mappedExpense = Expense(
            id: expense.id,
            remark: expense.remark,
            amount: expense.amount,
            date: expense.date,
            type: expenseType,
            color: "Blue"
        )
        expenses.append(mappedExpense)
    }
    return expenses
}

// Now fetch the expenses from Realm
var expenses = fetchExpensesFromRealm()
