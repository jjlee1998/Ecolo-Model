//
//  Matrix.swift
//  Ecolo Model Testing
//
//  Created by Jonathan J. Lee on 3/28/17.
//  Copyright © 2017 Jonathan J. Lee. All rights reserved.
//

import Foundation

protocol MatrixReady {}
extension Double: MatrixReady {}
extension Int: MatrixReady {}

func * (first: Matrix<Double>, second: Matrix<Double>) -> Matrix<Double>? {
    guard first.columns == second.rows else {
        return nil
    }
    var result = Matrix(rows: first.rows, columns: second.columns, fillValue: 0.0)!
    for columnIndex in 0..<result.columns {
        for rowIndex in 0..<result.rows {
            var newValue = 0.0
            let firstRow = first.getRow(rowIndex)
            let secondColumn = second.getColumn(columnIndex)
            guard firstRow != nil && secondColumn != nil else {
                return nil
            }
            for index in 0..<firstRow!.count {
                newValue += firstRow![index] * secondColumn![secondColumn!.count - 1 - index]
            }
            result.setElement(row: rowIndex, column: columnIndex, newElement: newValue)
        }
    }
    return result
}

struct Matrix<Element: MatrixReady>: CustomStringConvertible {
    
    fileprivate var elements = [[Element]]()
    let rows: Int
    let columns: Int
    
    init?(rows: Int, columns: Int, fillValue: Element) {
        guard rows > 0 && columns > 0 else {
            return nil
        }
        self.rows = rows
        self.columns = columns
        for columnIndex in 0..<columns {
            elements.append([Element]())
            for _ in 0..<rows {
                elements[columnIndex].append(fillValue)
            }
        }
    }
    
    @discardableResult mutating func setElement(row: Int, column: Int, newElement: Element) -> Bool {
        if row < 0 || row >= rows || column < 0 || column >= columns {
            return false
        } else {
            elements[column][row] = newElement
            return true
        }
    }
    
    func getElement(row: Int, column: Int) -> Element? {
        if row < 0 || row >= rows || column < 0 || column >= columns {
            return nil
        } else {
            return elements[column][row]
        }
    }
    
    func getColumn(_ columnIndex: Int) -> [Element]? {
        if columnIndex < 0 || columnIndex >= columns {
            return nil
        } else {
            return elements[columnIndex]
        }
    }
    
    func getRow(_ rowIndex: Int) -> [Element]? {
        if rowIndex < 0 || rowIndex >= rows {
            return nil
        } else {
            var row = [Element]()
            for column in elements {
                row.append(column[rowIndex])
            }
            return row
        }
    }
    
    mutating func map(_ function: (Element) -> Element) {
        for columnIndex in 0..<columns {
            elements[columnIndex] = elements[columnIndex].map(function)
        }
    }
    
    //Method to find identity matrix
    //Method to return the adjoint matrix
    //Method to find determinant
    //Method to return transpose
    
    var description: String {
        var maximumLength = 0
        for column in elements {
            for element in column {
                let elementStringCount = String(describing: element).characters.count
                if elementStringCount > maximumLength {maximumLength = elementStringCount}
            }
        }
        var result = "┌" + String(repeating: " ", count: 1 + (maximumLength + 1) * columns) + "┐"
        for rowIndex in 1...rows {
            guard let row = getRow(rows - rowIndex) else {
                return "Could not print Matrix; encountered problem with Row \(rowIndex)"
            }
            result += "\n│ "
            for element in row {
                var elementString = String(describing: element)
                let spacesToAdd = maximumLength - elementString.characters.count
                if spacesToAdd > 0 {
                    elementString += String(repeating: " ", count: spacesToAdd)
                }
                result += elementString + " "
            }
            result += "│"
        }
        result += "\n└" + String(repeating: " ", count: 1 + (maximumLength + 1) * columns) + "┘"
        return result
    }
}
