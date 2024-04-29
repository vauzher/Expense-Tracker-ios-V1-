//
//  Expense_Tracker_iosApp.swift
//  Expense Tracker ios
//
//  Created by Hama Nashwan on 15/12/2022.
//

import SwiftUI

@main
struct Expense_Tracker_iosApp: App {
    var body: some Scene {
        WindowGroup {
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            ContentView()
        }
    }
}
