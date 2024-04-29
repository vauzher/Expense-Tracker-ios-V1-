//
//  Expenseviewmodel.swift
//  Expense Tracker ios
//
//  Created by Hama Nashwan on 16/12/2022.
//

import SwiftUI
import RealmSwift

class ExpenseRealm: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var amount: Double = 0
    @objc dynamic var type: String = "" // Assuming you have a string type for expense type
    @objc dynamic var date: Date = Date()
    @objc dynamic var remark: String = ""
    @objc dynamic var cat: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Expenseviewmodel: ObservableObject {
    
    // prop
    @Published var dataChanged = false // Add this property
    @Published var startdate: Date = Date()
        @Published var enddate: Date = Date()
        @Published var currentmonthstartdate: Date = Date()
        @Published var tabname: ExpenseType = .expense
        @Published var showfilterview: Bool = false
        @Published var addnewExpense: Bool = false
        @Published var amoount: String = ""
        @Published var type: ExpenseType = .all
        @Published var date: Date = Date()
        @Published var remark: String = ""
        @Published var expenses: [Expense] = [] // Initialize as empty array here
        @Published var cat: String = ""
        
    
        init() {
            // Initialize ViewModel
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month], from: Date())
            startdate = calendar.date(from: components)!
            currentmonthstartdate = calendar.date(from: components)!
//            cat = "Food"
            // Fetch expenses from Realm and populate the expenses array
            expenses = fetchExpensesFromRealm()
        }
        
        // Fetch expenses from Realm and convert them into Expense objects
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
                    cat: expense.cat// You might want to add color property here, adjust accordingly
                )
                expenses.append(mappedExpense)
            }
            return expenses
        }
    // ....
    func currentmonthdatestring()->String{
        return currentmonthstartdate.formatted(date: .abbreviated, time: .omitted) + " - " + Date().formatted(date:.abbreviated, time: .omitted)
    }
    func convertexpensesTocurrency(expenses:[Expense],type:ExpenseType = .all )->String{
        var value:Double = 0
        value = expenses.reduce(0, { partialResult, expenses in
            return partialResult + (type == .all ?(expenses.type == .income ? expenses.amount : -expenses.amount) : (expenses.type == type ? expenses.amount : 0))
            
            
        })
        return convertnumbertoprice(value: value)
    }
    
    // convert data to string
    func convertdatetostring()->String{
        return startdate.formatted(date: .abbreviated, time: .omitted) + " - " + enddate.formatted(date:.abbreviated, time: .omitted)
    }
    // converta raqam bo price
    func convertnumbertoprice(value:Double)->String{
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: .init(value:value)) ?? "0.00$"
    }
    // clearing all data
    func cleardata( ){
        date = Date()
        type = .all
        remark = ""
        amoount = ""
        cat = ""
    }
    func reloadExpenses() {
           expenses = fetchExpensesFromRealm()
       }
    
    // save data
    func savedata(){
        // do action
        let realm = try! Realm()
        
        try! realm.write {
            let expenseRealm = ExpenseRealm()
            expenseRealm.amount = Double(amoount) ?? 0
            expenseRealm.type = type.rawValue
            expenseRealm.date = date
            expenseRealm.remark = remark
            expenseRealm.cat = cat
            realm.add(expenseRealm)
        }
        dataChanged = true

        // Clear the input fields after saving
        cleardata()
    }
    
    
}



