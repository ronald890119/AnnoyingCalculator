//
//  ContentView.swift
//  AnnoyingCalculator
//
//  Created by Ronald on 2024/2/21.
//

import SwiftUI

enum Buttons: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case add = "+"
    case sub = "-"
    case mul = "×"
    case div = "÷"
    case equal = "="
    case clear = "AC"
    case dot = "."
    case sign = "+/-"
    case percent = "%"
    
    var buttonColour: Color {
        switch self {
        case .clear, .sign, .percent:
            return Color(.systemGray6)
        
        case .div, .mul, .sub, .add, .equal:
            return Color.orange
            
        default:
            return Color.gray
        }
    }
    
    var textColour: Color {
        switch self {
        case .clear, .sign, .percent:
            return Color.black
        default:
            return Color.white
        }
    }
}

struct ContentView: View {
    let buttons: [[Buttons]] = [
        [.clear, .seven, .four, .one],
        [.sign, .eight, .five, .two],
        [.percent, .nine, .six, .three, .dot],
        [.div, .mul, .sub, .add, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                // numbers
                HStack {
                    Spacer()
                    Text("0")
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }.padding()
                
                // buttons
                HStack {
                    ForEach(buttons, id: \.self) { col in
                        VStack(spacing: 15) {
                            ForEach(col, id: \.self) { button in
                                Button(action: {
                                    
                                }, label: {
                                    Text(button.rawValue)
                                        .frame(width: 85, height: 85)
                                        .background(button.buttonColour)
                                        .foregroundColor(button.textColour)
                                        .cornerRadius(45)
                                        .font(.system(size: 40))
                                        .padding([.leading, .bottom, .trailing], 3)
                                })
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
