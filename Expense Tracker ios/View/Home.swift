//
//  Home.swift
//  Expense Tracker ios
//
//  Created by Hama Nashwan on 15/12/2022.
//

import SwiftUI
import RealmSwift

struct Home: View {
    @StateObject var expenseviewmodel:Expenseviewmodel = Expenseviewmodel()
    var body: some View {
        ScrollView(.vertical,showsIndicators: false ){
        
            VStack(){
                HStack(){
                    VStack(alignment: .leading, spacing: 4){
                     Text("Welcome!")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        Text("Ahmed")
                            .font(.title2.bold())
                            .foregroundColor(.black)
                     
                        
                            
                        
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    NavigationLink{
                        Filtereddetail()
                            .environmentObject(expenseviewmodel)
                    } label: {
                        Image(systemName: "hexagon.fill")
                            .foregroundColor(.gray)
                            .overlay(content:{
                                Circle()
                                    .stroke(.white,lineWidth: 2)
                                    .padding(7)
                            })
                            .frame(width:40,height: 40)
                            .background(Color.white)
                            .shadow(color:.black.opacity(0.1),radius: 5,x:5,y: 5)
                    }
                    
                }
                expensecardview().environmentObject(expenseviewmodel)

               
                Spacer(minLength: 250)
                transactionview()
                
            }
            .padding()
                
        }
        .background{
            Color("bg")
                .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $expenseviewmodel.addnewExpense){
            expenseviewmodel.cleardata()
            
        } content: {
            newexpense()
                .environmentObject(expenseviewmodel)
        }
        .overlay(alignment:.bottomTrailing){
            addbutton()
            
        }
        
        .onReceive(expenseviewmodel.$dataChanged) { _ in
                   // Reload data when dataChanged is true
                   if expenseviewmodel.dataChanged {
                       expenseviewmodel.expenses = expenseviewmodel.fetchExpensesFromRealm()
                       expenseviewmodel.dataChanged = false // Reset dataChanged after reloading
                   }
               }
    }
    
    // add new expense button
    @ViewBuilder
    func addbutton()->some View{
        Button{
            expenseviewmodel.addnewExpense.toggle()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 25,weight: .medium))
                .foregroundColor(.white)
                .frame(width: 55,height: 55)
                .background{
                    Circle()
                        .fill(
                            .linearGradient(colors: [Color("grad1"),
                                            Color("grad2"),Color("grad3")], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .shadow(color: .black.opacity(0.1), radius: 5,x:5,y:5)
        }
        .padding()
    }
    
    
    /// history aw tshtet mrovi krin 
    @ViewBuilder
    func transactionview()->some View{
        VStack(spacing: 15){
            Text("Transaction")
                .font(.title2.bold())
                .foregroundColor(.black)
                .opacity(0.7)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.bottom)
            
            ForEach(expenseviewmodel.expenses){
                expense in
                // data yet mrovi sarf krin han wargrin
                transationcardview(expense: expense)
                                .environmentObject(expenseviewmodel)
            }
        }
        .padding(.top)
        
    }
    
   
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
