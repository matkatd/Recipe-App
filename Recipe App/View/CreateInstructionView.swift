//
//  CreateInstructionView.swift
//  Recipe App
//
//  Created by David T on 12/2/24.
//

import SwiftUI

struct CreateInstructionView: View {
    
    var instruction: String?
    
    @State private var text: String = ""
    
    var onClose: () -> Void
    
    var onSave: (String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section("Instruction") {
                    TextField("Enter the next step", text: $text)
                    
                    Button(action: {
                        guard !text.isEmpty else { return }
                        onSave(text)
                    }) {
                        HStack {
                            Spacer()
                            Text("Save Instruction")
                            Spacer()
                        }
                    }
                    .buttonStyle(.borderless)
                    .foregroundColor(.blue)
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
            if let instruction = instruction {
                text = instruction
            }
        }
    }
}

