//
//  CreateIngredientView.swift
//  Recipe App
//
//  Created by David T on 12/2/24.
//

import SwiftUI

struct CreateIngredientView: View {
    
    var ingredient: Ingredient?
    
    @State private var name: String = ""
    @State private var amount: String = ""
    @State private var unit: String = ""
    
    var onClose: () -> Void
    
    var onSave: (Ingredient) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section("Ingredient") {
                    VStack {
                        HStack {
                            TextField("Name", text: $name)
                            TextField("Quantity", text: $amount)
                                .keyboardType(.numbersAndPunctuation)
                            TextField("Unit", text: $unit)
                        }
                        Divider()
                        Button(action: {
                            guard !name.isEmpty else { return }
                            
                            let ingredient = ingredient ?? Ingredient(name: name, unit: unit, amount: Double(amount) ?? 0)
                            ingredient.name = name
                            ingredient.unit = unit
                            
                            guard let amountValue = Double(amount) else {
                                let fractionParts = amount.split(separator: "/").compactMap { Double($0) }
                                                    
                                if fractionParts.count == 2 {
                                    let numerator = fractionParts[0]
                                    let denominator = fractionParts[1]
                                    let result = numerator / denominator
                                    ingredient.amount = result
                                    onSave(ingredient)
                                    return
                                }
                                print("Invalid quantity input: \(amount)") // Debug output
                                return
                            }
                            
                            ingredient.amount = amountValue
                            onSave(ingredient)
                        }) {
                            HStack {
                                Spacer()
                                Text("Save Ingredient")
                                Spacer()
                            }
                        }
                        .buttonStyle(.borderless)
                        .foregroundColor(.blue)
                    }
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {onClose()}) {
                        Text("Cancel")
                        
                    }
                }
            }
        }
        
        .onAppear {
            if let ingredient = ingredient {
                name = ingredient.name
                amount = String(ingredient.amount)
                unit = ingredient.unit ?? ""
            }
        }
    }
}

