//
//  ContentView.swift
//  Expense Tracker ios
//
//  Created by Hama Nashwan on 15/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Home()
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
