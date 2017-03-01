//
//  CalculatorViewController.swift
//  ExamOne
//
//  Created by Chris Chadillon on 2017-02-26.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // Instances Properties
    let theBrain = Brain()
    var theOperator = Operator.PI
    var operandOne = 0.0
    var operandTwo = 0.0
    var objectToSaveCalculationTo:CalculationSavable!
    
    // Outlets
    @IBOutlet weak var operatorSeg: UISegmentedControl!
    @IBOutlet weak var operandOneText: UITextField!
    @IBOutlet weak var operandTwoText: UITextField!
    @IBOutlet weak var resultText: UITextField!
    
    // Actions
    @IBAction func doCalculate(_ sender: UIButton) {
        self.doCalcResult()
        let theCalculation = Calculation(operandOne: Double(self.operandOne), operandTwo: Double(self.operandTwo), theOperator: self.theOperator, theResult: theBrain.result)
        self.objectToSaveCalculationTo.saveACalculation(aCalculation: theCalculation)
        self.navigationController!.popViewController(animated: true)
    }
    
    func doCalcResult() {
        switch self.theOperator {
        case .PI,
             .Euler:
            self.theBrain.performOperation(symbol: self.theOperator.rawValue)
        case .SqRoot,
             .ChangeSign:
            var op1 = 0.0
            if let o1 = Double(self.operandOneText.text!) {
                op1 = o1
            }
            self.operandOne = op1
            self.theBrain.setCurrentResult(aResult: op1)
            self.theBrain.performOperation(symbol: self.theOperator.rawValue)
        case .Addition,
             .Subtraction,
             .Multiply,
             .Divide:
            var op1 = 0.0
            var op2 = 0.0
            if let o1 = Double(self.operandOneText.text!) {
                op1 = o1
            }
            if let o2 = Double(self.operandTwoText.text!) {
                op2 = o2
            }
            self.operandOne = op1
            self.operandTwo = op2
            self.theBrain.setCurrentResult(aResult: op1)
            self.theBrain.performOperation(symbol: self.theOperator.rawValue)
            self.theBrain.setCurrentResult(aResult: op2)
            self.theBrain.performOperation(symbol: Operator.Equals.rawValue)
            
        case .Equals: break
        }
        self.resultText.text = theBrain.result.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.operatorSeg.addTarget(self, action: #selector(operatorDidChange(sender:)), for: .valueChanged)
        
        self.operandOneText.isEnabled = false
        self.operandTwoText.isEnabled = false
        self.resultText.isEnabled = false
    }
    
    @IBAction func updateResult(_ sender: UIButton) {
        self.doCalcResult()
    }
}

extension CalculatorViewController {
    func operatorDidChange(sender: UISegmentedControl) {
        let selectedOperator = Operator.from(int:sender.selectedSegmentIndex)
        self.theOperator = selectedOperator
        switch selectedOperator {
        case .PI,
             .Euler:
            self.operandOneText.isEnabled = false
            self.operandOneText.text = ""
            self.operandTwoText.isEnabled = false
            self.operandTwoText.text = ""
        case .SqRoot,
             .ChangeSign:
            self.operandOneText.isEnabled = true
            self.operandTwoText.isEnabled = false
            self.operandTwoText.text = ""
        case .Addition,
             .Subtraction,
             .Multiply,
             .Divide:
            self.operandOneText.isEnabled = true
            self.operandTwoText.isEnabled = true
        case .Equals: break
        }
    }
}
