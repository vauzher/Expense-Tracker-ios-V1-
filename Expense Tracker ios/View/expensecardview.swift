//
//  expensecardview.swift
//  Expense Tracker ios
//
//  Created by Hama Nashwan on 19/12/2022.
//

import SwiftUI
import RealmSwift

struct expensecardview: View {
    @EnvironmentObject var expenseviewmodel: Expenseviewmodel
    var isfilter: Bool = false
    
    var body: some View {
        VStack{
            
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color("grad1"), Color("grad2"), Color("grad3")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .frame(height: 220)
                .padding(.top)
                .overlay(
                    VStack(spacing: 15) {
                        VStack(spacing: 15) {
                            Text(isfilter ? expenseviewmodel.convertdatetostring() : expenseviewmodel.currentmonthdatestring())
                                .font(.caption)
                                .fontWeight(.semibold)
                            Text(expenseviewmodel.convertexpensesTocurrency(expenses: expenseviewmodel.expenses))
                                .font(.system(size: 35, weight: .bold))
                                .lineLimit(1)
                                .padding(.bottom, 5)
                        }
                        .offset(y: -10)
                        
                        HStack(spacing: 15) {
                            Image(systemName: "arrow.down")
                                .font(.caption.bold())
                                .foregroundColor(Color("green"))
                                .frame(width: 30, height: 30)
                                .background(Color.white.opacity(0.7))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Income")
                                    .font(.caption)
                                    .opacity(0.7)
                                
                                Text(expenseviewmodel.convertexpensesTocurrency(expenses: expenseviewmodel.expenses, type: .income))
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                                    .fixedSize()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(systemName: "arrow.up")
                                .font(.caption.bold())
                                .foregroundColor(Color("red"))
                                .frame(width: 30, height: 30)
                                .background(Color.white.opacity(0.7))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Expenses")
                                    .font(.caption)
                                    .opacity(0.7)
                                
                                Text(expenseviewmodel.convertexpensesTocurrency(expenses: expenseviewmodel.expenses, type: .expense))
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                                    .fixedSize()
                            }
                        }
                        .padding(.horizontal)
                        .padding(.trailing)
                        .offset(y: 15)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                )
        }
        }
    }
}
