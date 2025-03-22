//
//  ContentView.swift
//  Math24
//
//  Created by Kyle Yang on 3/10/25.
//

import SwiftUI
import SwiftData

// Colors
let lightBlue = Color(red: 0.70, green: 0.80, blue: 0.9)
let darkBlue = Color(red: 0.94, green: 0.97, blue: 1.0)
let lightOrange = Color(red: 1, green: 0.95, blue: 0.86)
let darkOrange = Color(red: 1, green: 0.67, blue: 0.36)

// Define target
let target = 24

struct ContentView: View {
    @StateObject var gameLogic = GameLogic()
    
    // Define the grid layout with 2 columns
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    // Define all possible operations
    let operations: [Character] = ["+", "-", "×", "÷"]
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    gameLogic.skip()
                 }) {
                     Text("Skip")
                         .font(.title)
                         .padding()
                         .background(Color.orange)
                         .foregroundColor(.white)
                         .cornerRadius(10)
                 }
                
                Button(action: {
                    gameLogic.refresh()
                 }) {
                     Text("Refresh")
                         .font(.title)
                         .padding()
                         .background(Color.orange)
                         .foregroundColor(.white)
                         .cornerRadius(10)
                 }
            }
            .padding()
            
            VStack {
                // Grid container (LazyVGrid)
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 20) {
                        // Creating 4 items to fill the 2x2 grid
                        ForEach(0..<4, id: \.self) { index in
                            // Card view for each item in the grid
                            if let num = gameLogic.numbers[index] {
                                if gameLogic.numbersRemaining == 1 {
                                    NumberCardView(cardName: "\(num)", backgroundColor: gameLogic.numbers[index] == target ? darkOrange : Color.gray)
                                } else {
                                    NumberCardView(cardName: "\(num)", backgroundColor: index == gameLogic.selectedNumIndex ? lightBlue : darkBlue)
                                        .onTapGesture {
                                            // Change selected card
                                            gameLogic.selectNum(index: index)
                                        }
                                }
                            } else {
                                NumberCardView(cardName: "", backgroundColor: Color.white)
                            }
                        }
                    }
                    .padding()
                }
            }
            
            HStack {
                ForEach(operations, id: \.self) { operation in
                    // Card view for each item in the grid
                    OperationCardView(cardName: operation, isSelected: operation == gameLogic.selectedOperation)
                        .onTapGesture {
                            // Change selected card
                            gameLogic.selectOperation(operation: operation)
                        }
                        .disabled(gameLogic.numbersRemaining == 1)
                }
            }
        }
        .scrollDisabled(true)
        .padding()
    }
}

struct NumberCardView: View {
    let cardName: String
    let backgroundColor: Color
    
    var body: some View {
        ZStack {
            // Card background color
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
                .frame(height: 150)
            
            // Card label
            Text(cardName)
                .font(.title)
                .foregroundColor(.black)
                .bold()
        }
        .animation(.easeInOut(duration: 0.3), value: backgroundColor)
    }
}

struct OperationCardView: View {
    let cardName: Character
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            // Card background color
            RoundedRectangle(cornerRadius: 20)
                .fill(isSelected ? darkOrange : lightOrange)
                .frame(height: 100)
            
            // Card label
            Text(String(cardName))
                .font(.title)
                .foregroundColor(isSelected ? lightOrange : darkOrange)
                .bold()
        }
        .animation(.easeInOut(duration: 0.3), value: isSelected)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
