//
//  GameLogic.swift
//  Math24
//
//  Created by Kyle Yang on 3/17/25.
//

import SwiftUI

class GameLogic: ObservableObject {
    @Published var numbers: [Int] = []
    @Published var disabled: [Bool] = []
    @Published var firstNumIndex: Int?
    @Published var secondNumIndex: Int?
    @Published var operation: Character?
    @Published var currentExpression: Int?
    @Published var isCorrect: Bool = false
    @Published var message: String = ""
    
    init() {
        generateRandomNumbers()
    }

    func refresh() {
        firstNumIndex = nil
        secondNumIndex = nil
        operation = nil
    }
    
    func generateRandomNumbers() {
        numbers = (1...4).map { _ in Int.random(in: 1...9) }
        message = "Math 24"
        isCorrect = false
    }
    
    func selectNum(index: Int) {
        if firstNumIndex != nil {
            secondNumIndex = index
            evaluate()
        } else {
            firstNumIndex = index
        }
    }
    
    func evaluate() {
        let firstNum = numbers[firstNumIndex ?? 0]
        let secondNum = numbers[secondNumIndex ?? 0]
        switch operation {
            case "+":
                currentExpression = firstNum + secondNum
            case "-":
                currentExpression = firstNum - secondNum
            case "×":
                currentExpression = firstNum * secondNum
            case "÷":
//              Not Implemented
                currentExpression = 0
            default:
                currentExpression = 0
        }
        refresh()
    }

    func checkSolution() {
        if currentExpression == 24 {
            message = "Correct!"
            isCorrect = true
        } else {
            message = "Try again!"
            isCorrect = false
        }
    }
    
    func getResult() -> String {
        var str = ""
        if let v = currentExpression {
           str = "\(v)"
        }
        return str
    }
    
}
