//
//  GameLogic.swift
//  Math24
//
//  Created by Kyle Yang on 3/17/25.
//

import SwiftUI

class GameLogic: ObservableObject {
    @Published var generatedNumbers: [Int] = []
    @Published var numbers: [Int?] = []
    @Published var selectedNumIndex: Int?
    @Published var secondNumIndex: Int?
    @Published var selectedOperation: Character?
    @Published var numbersRemaining: Int
    
    init() {
        numbersRemaining = 4
        generateRandomNumbers()
        refresh()
    }

    func refresh() {
        numbers = generatedNumbers
        selectedNumIndex = nil
        selectedOperation = nil
        numbersRemaining = 4
    }
    
    func skip() {
        generateRandomNumbers()
        refresh()
    }
    
    func generateRandomNumbers() {
        generatedNumbers = (1...4).map { _ in Int.random(in: 1...9) }
    }
    
    func selectNum(index: Int) {
        if selectedOperation != nil && selectedNumIndex != nil && index != selectedNumIndex {
            do {
                try evaluate(secondNumIndex: index)
            } catch OperationError.unimplementedOperation {
                print("This operation has not yet been implemented")
            } catch {
                print("Invalid operation")
            }
        } else {
            selectedNumIndex = index == selectedNumIndex ? nil : index
        }
    }
    
    func selectOperation(operation: Character) {
        selectedOperation = operation == selectedOperation ? nil : operation
    }
    
    func evaluate(secondNumIndex: Int) throws {
        if let firstNumIndex = selectedNumIndex, let firstNum = numbers[firstNumIndex], let secondNum = numbers[secondNumIndex] {
            switch selectedOperation {
                case "+":
                    numbers[secondNumIndex] = firstNum + secondNum
                case "-":
                    numbers[secondNumIndex] = firstNum - secondNum
                case "×":
                    numbers[secondNumIndex] = firstNum * secondNum
                case "÷":
                    throw OperationError.unimplementedOperation
                default:
                    throw OperationError.invalidOperation
            }
            numbers[firstNumIndex] = nil
            numbersRemaining -= 1
            selectedOperation = nil
            selectedNumIndex = secondNumIndex
            
            // If correct...
            if numbersRemaining == 1 && numbers[secondNumIndex] == 24 {
                let seconds = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.skip()
                }
            }
        }
    }
}

enum OperationError: Error {
    case unimplementedOperation
    case invalidOperation
}
