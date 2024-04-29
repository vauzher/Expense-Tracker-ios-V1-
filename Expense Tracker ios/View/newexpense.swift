//
//  newexpense.swift
//  Expense Tracker ios
//
//  Created by Hama Nashwan on 23/12/2022.
//

import SwiftUI
import RealmSwift


struct newexpense: View {
    @EnvironmentObject var expenseviewmodel:Expenseviewmodel
    // enviroment values
    @Environment(\.self) var env
    var body: some View {
        VStack{
            VStack(spacing: 15){
                Text("Add Expense")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .opacity(0.5)
                    .foregroundColor(.black)
                
                // custom textfield
                //for currency symbol
                if let symbol = expenseviewmodel.convertnumbertoprice(value: 0).first{
                    TextField("0",text: $expenseviewmodel.amoount)
                        .font(.system(size: 35))
                        .foregroundColor(Color("grad2"))
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background{
                            Text(expenseviewmodel.amoount == "" ? "0" :
                                    expenseviewmodel.amoount)
                            .font(.system(size: 35))
                            .opacity(0)
                            .foregroundColor(.black)
                            .overlay(alignment:.leading){
                                Text(String(symbol))
                                    .opacity(0.55)
                                    .offset(x:-15,y:5)
                                    
                            }
                        }
                        .padding(.vertical,10)
                        .frame(maxWidth:.infinity)
                        .background{
                            Capsule()
                                .fill(.white)
                        }
                        .padding(.horizontal,20)
                        .padding(.top)
                }
                // custom label
                Label{
                    TextField("Remark",text:$expenseviewmodel.remark)
                        .padding(.leading,10)
                        .foregroundColor(.black)
                        

                } icon: {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.title3)
                        .foregroundColor(Color("grey"))
                }
                .padding(.vertical,20)
                    .padding(.horizontal,15)
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(.white)
                    }
                    .padding(.top,25)
                Label{
                    // check boxes
                    customcheckboxes()
                } icon: {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.title3)
                        .foregroundColor(Color("grey"))
                }
                .padding(.vertical,20)
                    .padding(.horizontal,15)
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(.white)
                    }
                    .padding(.top,5)
                
                Label{
                    DatePicker.init("", selection: $expenseviewmodel.date,in:Date.distantPast...Date(),displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .frame(maxWidth:.infinity,alignment: .leading)
                        .padding(.leading,10)
                } icon: {
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundColor(Color("grey"))
                }
                .padding(.vertical,20)
                    .padding(.horizontal,15)
                    .background{
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(.white)
                    }
                    .padding(.top,5)
                
            }
            .frame(maxHeight: .infinity,alignment:.center)
            // Save button
            Button( action:{
                expenseviewmodel.savedata()}) {
                    Text("Save")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [Color("grad1"), Color("grad2"), Color("grad3")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                            }
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
            }
            // enter info to enable save button 
            .disabled(expenseviewmodel.remark == "" || expenseviewmodel.type == .all || expenseviewmodel.amoount == "")
            .opacity(expenseviewmodel.remark == "" || expenseviewmodel.type == .all || expenseviewmodel.amoount == "" ? 0.6 : 1)
        }
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background{
            Color("bg")
                .ignoresSafeArea()
        }
        .overlay(alignment: .topTrailing){
            // Close Button
            
            Button{
                env.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.black)
                    .opacity(0.7)
            }
            .padding()
        }
    }
    //check boxes
    @ViewBuilder
    func customcheckboxes()->some View{
        HStack(spacing: 10){
            ForEach([ExpenseType.income,ExpenseType.expense],id:\.self){
                type in ZStack{
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(.black,lineWidth: 2)
                        .opacity(0.5)
                        .frame(width: 20,height: 20)
                    
                    if expenseviewmodel.type == type{
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundColor(Color("black"))
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    expenseviewmodel.type = type
                }
                
                Text(type.rawValue.capitalized)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .opacity(0.7)
                    .padding(.trailing,10)
                    .foregroundColor(.black)

            }
        }
        .frame(maxWidth:.infinity,alignment: .leading)
        .padding(.leading,10)
    }
}

struct newexpense_Previews: PreviewProvider {
    static var previews: some View {
        newexpense()
            .environmentObject(Expenseviewmodel())
        
    }
}
