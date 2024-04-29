//
//  transationcardview.swift
//  Expense Tracker ios
//
//  Created by Hama Nashwan on 16/12/2022.
//

import SwiftUI

struct transationcardview: View {
    var expense:Expense
    @EnvironmentObject var expenseViewmodel:Expenseviewmodel
    var body: some View {
        HStack(spacing: 12){
            // 7arfa awl bita avatar
            if let first=expense.remark.first{
                Text(String(first))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(width: 50,height: 50)
                    .background{
                        Circle()
                            .fill(Color(expense.color))
                        
                    }
                    .shadow(color: .black.opacity(0.08), radius: 5,x:5,y:5)
            }
            Text(expense.remark)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .lineLimit(1)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            VStack(alignment: .leading, spacing: 7) {
                          
                           
                           // Display transaction value
                           Text(expenseViewmodel.convertnumbertoprice(value: expense.amount))
                               .font(.callout)
                               .opacity(0.7)
                       }
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 15,style: .continuous)
                .fill(.white)
        }
    }
}

struct transationcardview_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
