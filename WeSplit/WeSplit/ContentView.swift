//
//  ContentView.swift
//  WeSplit
//
//  Created by loku on 04/08/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 5
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [5, 10, 15, 20, 0]

    var totalPerPerson: Double {
        guard checkAmount > 0 else { return 0 }
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = tipSelection * (checkAmount / 100)
        
        let totalValue = checkAmount + tipValue
        return totalValue / peopleCount
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Check amount & number of people") {
                    TextField(
                        "Check amount",
                        value: $checkAmount,
                        format: .currency(
                            code: Locale.current.currency?.identifier ?? "USD"
                        )
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }

                Section("Tip percentage") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Total per person") {
                    Text(
                        totalPerPerson,
                        format: .currency(
                            code: Locale.current.currency?.identifier ?? "USD"
                        )
                    )
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
