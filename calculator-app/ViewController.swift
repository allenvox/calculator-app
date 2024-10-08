//
//  ViewController.swift
//  calculator-app
//
//  Created by Yuriy Grigoryev on 08.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calcWorkings: UILabel!
    @IBOutlet weak var calcResults: UILabel!
    
    var workings: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clear()
    }
    
    func clear() {
        workings = ""
        calcWorkings.text = ""
        calcResults.text = ""
    }
    
    func addToWorkings(_ value: String) {
        workings.append(value)
        calcWorkings.text = workings
    }
    
    func evaluateExpression() {
        if(!workings.isEmpty) {
            let expr = NSExpression(format: workings)
            let result = expr.expressionValue(with: nil, context: nil) as! Double
            calcResults.text = formatResult(result: result)
        }
    }

    @IBAction func tapClear(_ sender: Any) {
        clear()
    }
    
    @IBAction func tapNegative(_ sender: Any) {
        if(!workings.isEmpty) {
            workings.insert("(", at: workings.startIndex)
            workings.insert("-", at: workings.startIndex)
            addToWorkings(")")
            evaluateExpression()
        }
    }
    
    @IBAction func tapPercent(_ sender: Any) {
        if(!workings.isEmpty) {
            workings.insert("(", at: workings.startIndex)
            addToWorkings(")*0.01")
            evaluateExpression()
        }
    }
    
    @IBAction func tapDivide(_ sender: Any) {
        addToWorkings("/")
    }
    
    @IBAction func tapMultiply(_ sender: Any) {
        addToWorkings("*")
    }
    
    @IBAction func tapMinus(_ sender: Any) {
        addToWorkings("-")
    }
    
    @IBAction func tapPlus(_ sender: Any) {
        addToWorkings("+")
    }
    
    func isSpecialCharacter(_ char: Character) -> Bool {
        switch char {
        case "*":
            return true
        case "/":
            return true
        case "+":
            return true
        case ".":
            return true
        default:
            return false
        }
    }
    
    func isInputValid(_ input: String) -> Bool {
        if(workings.isEmpty) {
            return true
        }
        
        // input.first should not be a special character
        let firstCheck = !isSpecialCharacter(input.first!)
        
        // input.last should not be a special character
        let secondCheck = !isSpecialCharacter(input.last!)
        
        // there must not be two special characters next to each other
        var specialCharsIndices = [Int]()
        var current = 0
        for char in workings {
            if(isSpecialCharacter(char)) {
                specialCharsIndices.append(current)
            }
            current += 1
        }
        var previous = -1
        for i in specialCharsIndices {
            if(previous != -1) {
                if(i - previous == 1) {
                    return false
                }
            }
            previous = i
        }
        
        return true && firstCheck && secondCheck
    }
    
    func formatResult(result: Double) -> String {
        var style: String = "%.2f"
        if(result.truncatingRemainder(dividingBy: 1) == 0) {
            style = "%.0f"
        }
        return String(format: style, result)
    }
    
    @IBAction func tapEqual(_ sender: Any) {
        if !isInputValid(workings) {
            let alert = UIAlertController(title: "Invalid expression", message: "Check your input", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else {
            evaluateExpression()
        }
    }
    
    @IBAction func tapDecimal(_ sender: Any) {
        addToWorkings(".")
    }
    
    @IBAction func tapZero(_ sender: Any) {
        addToWorkings("0")
    }
    
    @IBAction func tapOne(_ sender: Any) {
        addToWorkings("1")
    }
    
    @IBAction func tapTwo(_ sender: Any) {
        addToWorkings("2")
    }
    
    @IBAction func tapThree(_ sender: Any) {
        addToWorkings("3")
    }
    
    @IBAction func tapFour(_ sender: Any) {
        addToWorkings("4")
    }
    
    @IBAction func tapFive(_ sender: Any) {
        addToWorkings("5")
    }
    
    @IBAction func tapSix(_ sender: Any) {
        addToWorkings("6")
    }
    
    @IBAction func tapSeven(_ sender: Any) {
        addToWorkings("7")
    }
    
    @IBAction func tapEight(_ sender: Any) {
        addToWorkings("8")
    }
    
    @IBAction func tapNine(_ sender: Any) {
        addToWorkings("9")
    }
}
