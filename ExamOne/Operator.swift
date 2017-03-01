//
//  Operators.swift
//  ExamOne
//
//  Created by Chris on 2017-02-27.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import Foundation

enum Operator : String {
    case PI = "π"
    case Euler = "e"
    case SqRoot = "√"
    case ChangeSign = "±"
    case Addition = "+"
    case Subtraction = "−"
    case Multiply = "×"
    case Divide = "÷"
    case Equals = "="
    
    var asInt:Int {
        switch self {
        case .PI: return 0
        case .Euler: return 1
        case .SqRoot: return 2
        case .ChangeSign: return 3
        case .Addition: return 4
        case .Subtraction: return 5
        case .Multiply: return 6
        case .Divide: return 7
        case .Equals: return 8
        }
    }
    
    static func from(int index:Int) -> Operator
    {
        switch index {
        case 0: return .PI
        case 1: return .Euler
        case 2: return .SqRoot
        case 3: return .ChangeSign
        case 4: return .Addition
        case 5: return .Subtraction
        case 6: return .Multiply
        case 7: return .Divide
        case 8: return .Equals
        default: return .PI
        }
    }
}
