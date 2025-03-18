//
//  ContentView.swift
//  Math24
//
//  Created by Kyle Yang on 3/10/25.
//

import SwiftUI
import SwiftData

import SwiftUI

struct ContentView: View {
    @StateObject var gameLogic = GameLogic()
    
    // Define the grid layout with 2 columns
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    let operations: [Character] = ["+", "-", "×", "÷"]
    
    var body: some View {
        VStack {
            Text("Math 24")
                .font(.title)
                .padding()
            
            VStack {
                // Grid container (LazyVGrid)
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 20) {
                        // Creating 4 items to fill the 2x2 grid
                        ForEach(0..<4, id: \.self) { index in
                            // Card view for each item in the grid
                            if let num = gameLogic.numbers[index] {
                                NumberCardView(cardName: "\(num)", isSelected: index == gameLogic.selectedNumIndex, isVisible: true)
                                    .onTapGesture {
                                        // Change selected card
                                        gameLogic.selectNum(index: index)
                                    }
                            } else {
                                NumberCardView(cardName: "", isSelected: false, isVisible: false)
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
                }
            }
        }
        .padding()
    }
}

struct NumberCardView: View {
    let cardName: String
    let isSelected: Bool
    let isVisible: Bool
    
    var body: some View {
        ZStack {
            // Card background color
            RoundedRectangle(cornerRadius: 20)
                .fill(isVisible ? (isSelected ? Color.blue : Color.gray) : Color.white)
                .frame(height: 150)
            
            // Card label
            Text(cardName)
                .font(.title)
                .foregroundColor(.white)
                .bold()
        }
        .animation(.easeInOut(duration: 0.3), value: isSelected)
    }
}

struct OperationCardView: View {
    let cardName: Character
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            // Card background color
            RoundedRectangle(cornerRadius: 20)
                .fill(isSelected ? Color.blue : Color.gray)
                .frame(height: 100)
            
            // Card label
            Text(String(cardName))
                .font(.title)
                .foregroundColor(.white)
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
