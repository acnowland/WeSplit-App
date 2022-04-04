//
//  ContentView.swift
//  WeSplit
//
//  Created by Adam Nowland on 3/28/22.
//

import SwiftUI

struct ContentView: View {
    // comments to commit test
    // data
    @State private var checkAmount = 0.0
    @State private var numberPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // computed properties
    var totalCheck: Double {
        let peopleCount = Double(numberPeople + 2)
        let tipSelection = Double(tipPercentage)
        return ((checkAmount * (tipSelection / 100)) + checkAmount) / peopleCount
    }
    
    var currencyFormatting: String {
        return Locale.current.currencyCode ?? "USD"
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyFormatting))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberPeople){
                        ForEach(2..<100){
                            Text("\($0) People")
                        }
                    }
                }
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip Percentage")
                }
                
                Section {
                    Text(checkAmount, format: .currency(code: currencyFormatting))
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                } header: {
                    Text("Total: ")
                }
                
                Section{
                    Text(totalCheck, format: .currency(code: currencyFormatting))
                } header: {
                    Text("Amount Per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro Max")
            .previewInterfaceOrientation(.portrait)
    }
}
