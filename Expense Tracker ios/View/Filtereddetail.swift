import SwiftUI

struct Filtereddetail: View {
    @EnvironmentObject var expenseViewmodel: Expenseviewmodel
    @Environment(\.self) var env
    @Namespace var animation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                HStack(spacing:15 ) {
                    // Button to dismiss
                    Button {
                        env.dismiss()
                    } label:{
                        Image(systemName: "arrow.backward.circle.fill")
                            .foregroundColor(.gray)
                            .frame(width:40,height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color:.black.opacity(0.1),radius: 5,x:5,y: 5)
                            .padding(6)
                    }
                    
                    Text("Transactions")
                        .font(.title.bold())
                        .opacity(0.8)
                        .padding(-2)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Button to show filter view
                    Button {
                        expenseViewmodel.showfilterview = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.gray)
                            .frame(width:40,height: 40)
                            .background(Color.white)
                            .shadow(color:.black.opacity(0.1),radius: 5,x:5,y: 5)
                    }
                    .padding()
                }
                
                customsegmentcontrol()
                    .padding(.top)
                
                // Display filter date with amount
                VStack(spacing: 15) {
                    Text(expenseViewmodel.convertdatetostring())
                        .opacity(0.7)
                    
                    Text(expenseViewmodel.convertexpensesTocurrency(expenses: expenseViewmodel.expenses, type: expenseViewmodel.tabname))
                        .font(.title.bold())
                        .opacity(0.9)
                        .animation(.none, value: expenseViewmodel.tabname)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                }
                .padding(.vertical,20)
                
                // Display transaction cards
                ForEach(expenseViewmodel.expenses.filter {
                    return $0.type == expenseViewmodel.tabname
                }) { expense in
                    transationcardview(expense: expense)
                        .environmentObject(expenseViewmodel)
                }
            }
        }
        .navigationBarHidden(true)
        .background {
            Color("bg")
                .ignoresSafeArea()
        }
        .overlay {
            filterview()
        }
    }
    
    // Filter view
    @ViewBuilder
    func filterview() -> some View {
        ZStack {
            Color.black
                .opacity(expenseViewmodel.showfilterview ? 0.25 : 0)
                .ignoresSafeArea()
            // Show filter options if `showfilterview` is true
            if expenseViewmodel.showfilterview {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Start Date")
                        .font(.caption)
                        .opacity(0.7)
                        .foregroundColor(.black)
                    
                    // Start Date Picker
                    DatePicker("", selection: $expenseViewmodel.startdate, in: Date.distantPast...Date(), displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                        .onChange(of: expenseViewmodel.startdate) { _ in
                            expenseViewmodel.reloadExpenses()
                        }

                    // End Date Picker
                    DatePicker("", selection: $expenseViewmodel.enddate, in: Date.distantPast...Date(), displayedComponents: [.date])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                        .onChange(of: expenseViewmodel.enddate) { _ in
                            expenseViewmodel.reloadExpenses()
                        }

                }
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                // Close button
                .overlay(alignment: .topTrailing) {
                    Button {
                        expenseViewmodel.showfilterview = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.black)
                            .padding(5)
                    }
                }
                .padding()
            }
        }
        .animation(.easeInOut, value: expenseViewmodel.showfilterview)
    }
    
    // Segment control
    @ViewBuilder
    func customsegmentcontrol() -> some View {
        HStack(spacing: 0) {
            ForEach([ExpenseType.income, ExpenseType.expense], id: \.rawValue.capitalized) { tab in
                Text(tab.rawValue)
                    .fontWeight(.semibold)
                    .foregroundColor(expenseViewmodel.tabname == tab ? .white : .black)
                    .foregroundColor(.black)
                    .opacity(expenseViewmodel.tabname == tab ? 1 : 0.7)
                    .padding(.vertical,12)
                    .frame(maxWidth: .infinity)
                    .background {
                        // Gradient background for selected tab
                        if expenseViewmodel.tabname == tab {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(LinearGradient(
                                    colors: [
                                        Color("grad1"),
                                        Color("grad2"),
                                        Color("grad3"),
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            expenseViewmodel.tabname = tab
                        }
                    }
            }
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
        }
    }
}

struct Filtereddetail_Previews: PreviewProvider {
    static var previews: some View {
        Filtereddetail()
            .foregroundColor(.black)
            .environmentObject(Expenseviewmodel())
    }
}
