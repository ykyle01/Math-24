//
//  GameLogic.swift
//  Math24
//
//  Created by Kyle Yang on 3/17/25.
//

import SwiftUI

class GameLogic: ObservableObject {
    @Published var numbers: [Int?] = []
    @Published var disabled: [Bool] = []
    @Published var selectedNumIndex: Int?
    @Published var secondNumIndex: Int?
    @Published var selectedOperation: Character?
    
    init() {
        generateRandomNumbers()
    }

    func refresh() {
        selectedNumIndex = nil
        selectedOperation = nil
    }
    
    func generateRandomNumbers() {
        numbers = (1...4).map { _ in Int.random(in: 1...9) }
    }
    
    func selectNum(index: Int) {
        if selectedOperation != nil && selectedNumIndex != nil {
            do {
                try evaluate(secondNumIndex: index)
            } catch OperationError.unimplementedOperation {
                print("This operation has not yet been implemented")
            } catch {
                print("Invalid operation")
            }
        } else {
            selectedNumIndex = index
        }
    }
    
    func selectOperation(operation: Character) {
        selectedOperation = operation
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
            refresh()
        }
        
    }
}

enum OperationError: Error {
    case unimplementedOperation
    case invalidOperation
}
