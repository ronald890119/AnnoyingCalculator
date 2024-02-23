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
    
    var buttonWidth: CGFloat {
        switch self {
        case .zero:
            return (UIScreen.main.bounds.width - 50) / 2 + 15
        default:
            return (UIScreen.main.bounds.width - 50) / 4
        }
    }
    
    var buttonHeight: CGFloat {
        return (UIScreen.main.bounds.width - 50) / 4
    }
}

enum Operations {
    case add, sub, mul, div, none
}

struct ContentView: View {
    var buttons: [[Buttons]] = [
        [.clear, .sign, .percent, .div],
        [.seven, .eight, .nine, .mul],
        [.four, .five, .six, .sub],
        [.one, .two, .three, .add],
        [.zero, .dot, .equal]
    ]
    
    @State var value = "0";
    @State var operation: Operations = .none;
    @State var firstNum = 0;
    @State var secondNum = 0;
    @State var hasResult: Bool = false;
    
    let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 18){
                // numbers
                HStack {
                    Spacer()
                    Text(value)
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }.padding()
                
                // buttons
                VStack(spacing: 18) {
                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 15) {
                            ForEach(row, id: \.self) { button in
                                Button(action: {
                                    self.onClick(button: button)
                                }, label: {
                                    Text(button.rawValue)
                                        .frame(width: button.buttonWidth, height: button.buttonHeight)
                                        .background(button.buttonColour)
                                        .foregroundColor(button.textColour)
                                        .cornerRadius(45)
                                        .font(.system(size: 40))
                                })
                            }
                        }
                    }
                }
            }
        }
    }
    
    func onClick(button: Buttons) {
        switch button {
        case .div, .mul, .sub, .add:
            if(button == .div) {
                self.operation = .div
            } else if(button == .mul) {
                self.operation = .mul
            } else if(button == .sub) {
                self.operation = .sub
            } else if(button == .add) {
                self.operation = .add
            }
            
            self.firstNum = Int(self.value) ?? 0;
            self.value = String(0);
        case .equal:
            self.secondNum = Int(self.value) ?? 0
            
            switch self.operation {
            case .add:
                self.value = String(self.firstNum + self.secondNum)
            case .sub:
                self.value = String(self.firstNum - self.secondNum)
            case .mul:
                self.value = String(self.firstNum * self.secondNum)
            case .div:
                self.value = String(self.firstNum / self.secondNum)
            case .none:
                break
            }
            
            self.operation = .none
            self.firstNum = 0
            self.secondNum = 0
        case .sign:
            if(self.value[self.value.startIndex] != "-") {
                self.value = "-" + self.value
            } else {
                self.value.remove(at: self.value.startIndex)
            }
        case .percent, .dot:
            break
        case .clear:
            self.value = "0"
            self.operation = .none
            self.firstNum = 0
            self.secondNum = 0
        default:
            if self.value == "0" {
                self.value = button.rawValue
            } else {
                self.value += button.rawValue
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
