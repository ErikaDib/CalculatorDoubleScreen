//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by student on 9/6/17.
//  Copyright © 2017 student. All rights reserved.
//

import Foundation






struct CalculatorBrain{
    
    private var accumulator: Double?
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
    }
    private var operations:Dictionary<String,Operation> =
    [
        
    "π":Operation.Constant(Double.pi),
     "e":Operation.Constant(M_E),
     "±":Operation.UnaryOperation({-$0}),
    "√":Operation.UnaryOperation(sqrt),//sqrt
    "∛":Operation.UnaryOperation(cbrt),
    "%":Operation.BinaryOperation({return $0.truncatingRemainder(dividingBy: $1)}),
    "cos":Operation.UnaryOperation(cos),//cos
    "sin":Operation.UnaryOperation(sin),
    "tan":Operation.UnaryOperation(tan),
    "㎡":Operation.UnaryOperation({return pow($0 , 2 )}),
    "㎥":Operation.UnaryOperation({return pow($0 , 3)}),
    "log(10)":Operation.UnaryOperation({return log($0)/log(10)}),
    "×":Operation.BinaryOperation({return $0 * $1}),
    "÷":Operation.BinaryOperation({return $0 / $1}),
    "+":Operation.BinaryOperation({return $0 + $1}),
    "-":Operation.BinaryOperation({return $0 - $1}),
    "=": Operation.Equals


    ]
    
    private struct  PendingBinaryOperation {
    
    let function : (Double,Double) -> Double
        let firstOperand:Double
        
        func perform(with secondOperand: Double) -> Double{
            return function(firstOperand,secondOperand)
        }
    }
    
    private var pedingBinaryOperation: PendingBinaryOperation?
    
    mutating func performOperation(_ symbol:String){
        if let operation=operations[symbol]{
            switch operation{
            case .Constant(let value):
                accumulator=value
            case .UnaryOperation(let function):
                if accumulator != nil{
                    accumulator=function(accumulator!)
                }
            case .BinaryOperation(let function):
                if(accumulator != nil){
                    pedingBinaryOperation=PendingBinaryOperation(function:function,firstOperand: accumulator!)
                    accumulator=nil
                }
            case .Equals:
                if(pedingBinaryOperation != nil && accumulator != nil){
                    accumulator=pedingBinaryOperation!.perform(with: accumulator!)
                    pedingBinaryOperation=nil
                }
            }
        }
        
    }
    mutating func setOperant(_ operand:Double){
    accumulator = operand
    
    }
    
    var result:Double?{
        get {
        return accumulator
        }
    }
    
    }
