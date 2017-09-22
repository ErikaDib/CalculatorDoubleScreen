//
//  ViewController.swift
//  Calculator
//
//  Created by student on 8/28/17.
//  Copyright © 2017 student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var brain:CalculatorBrain=CalculatorBrain()

   
    @IBOutlet weak var display: UILabel!
    
    var userInTHeMiddleOfTyping : Bool=false
    
    private let DOT="."
    private var sim=""
    
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text=String(newValue)
            
        }
    }
    
    
    @IBOutlet weak var secondScreen: UILabel!
    
    

    

    
    
    @IBAction func touchDigit(_ sender: UIButton) {
    
        let digit=sender.currentTitle!
        
        if (digit == "c"){
            display.text=" "
            secondScreen.text=" "
            return
        }
        
        let textCurrentlyInDisplay=display.text!
        //print("\(digit) was pressed")
       
        if userInTHeMiddleOfTyping{
            if(secondScreen.text == "0"){
                secondScreen.text=textCurrentlyInDisplay+digit
            }else{
                secondScreen.text=secondScreen.text!+textCurrentlyInDisplay+digit
            }
            
            if digit != DOT || display.text!.range(of: DOT) == nil{
                display.text=textCurrentlyInDisplay+digit
            }
            
        }else {
            
        if (digit == DOT){
                    display.text=textCurrentlyInDisplay+digit
                } else {
                    display.text=digit
                }
            
        }
        
        userInTHeMiddleOfTyping=true
        
    }
    


    
    @IBAction func performOperation(_ sender: UIButton) {
        if(userInTHeMiddleOfTyping){
            brain.setOperant(displayValue)
            userInTHeMiddleOfTyping=false
          
            
        }
        if let mathematicalSymbol=sender.currentTitle{
           
            
            brain.performOperation(mathematicalSymbol)
            secondScreen.text=secondScreen.text!+mathematicalSymbol
           
           
        }
        if let result = brain.result{
            displayValue=result
            secondScreen.text=" "
        }
        
            /*
            if mathematicalSymbol=="π"{
                display!.text=String(Double.pi)
        }
        */
    }
    
    }

