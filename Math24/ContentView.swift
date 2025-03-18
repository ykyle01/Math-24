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
    
    var body: some View {
        VStack {
            Text(gameLogic.message)
                .font(.title)
                .padding()
            
            VStack {
                // Grid container (LazyVGrid)
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 20) {
                        // Creating 4 items to fill the 2x2 grid
                        ForEach(0..<4, id: \.self) { index in
                            // Card view for each item in the grid
                            if index != 0 {
                                CardView(index: index, cardName: "\(gameLogic.numbers[index])", isSelected: true, isVisible: true)
                                    .onTapGesture {
                                        // Change selected card
                                        gameLogic.selectNum(index: index)
                                    }
                            } else {
                                CardView(index: index, cardName: "\(gameLogic.numbers[index])", isSelected: true, isVisible: false)
                                    .onTapGesture {
                                        // Change selected card
                                        gameLogic.selectNum(index: index)
                                    }
                            }
                        }
                    }
                    .padding()
                }
            }
            
            HStack {
                Button(action: {
                    gameLogic.operation = "+"
                }) {
                    Text("+")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    gameLogic.operation = "-"
                }) {
                    Text("-")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    gameLogic.operation = "*"
                }) {
                    Text("×")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    gameLogic.operation = "/"
                }) {
                    Text("÷")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            Text(gameLogic.getResult())
                .padding()
                .font(.title2)
        }
        .padding()
    }
}

struct CardView: View {
    let index: Int
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
