//
//  ViewController.swift
//  Calculator
//
//  Created by jose ramirez on 5/27/17.
//  Copyright © 2017 Jose Ramirez. All rights reserved.
//

import UIKit

enum modes{
    case not_set
    case addition
    case subtraction
    case multiplication
    case division
    case percent
    case plusMinus
}

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var labelString:String = ""
    var currentMode:modes = .not_set
    var savedNum:Double = 0
    var lastButtonWasMode:Bool = false
    var safe:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressPlus(_ sender: Any) {
        changeMode(newMode: .addition)
    }
    
    @IBAction func didPressSubtract(_ sender: Any) {
        changeMode(newMode: .subtraction)
    }
    
    @IBAction func didPressMultiply(_ sender: Any) {
        changeMode(newMode: .multiplication)
    }

    @IBAction func didPressDivision(_ sender: Any) {
        changeMode(newMode: .division)
    }
    @IBAction func didPressEquals(_ sender: Any) {
        guard let labelDouble:Double = Double(labelString) else {
            return
        }
        if(currentMode == .not_set || lastButtonWasMode){
            return
        }
        if(currentMode == .addition){
            savedNum += labelDouble
        } else if(currentMode == .subtraction){
            savedNum -= labelDouble
        } else if(currentMode == .multiplication){
            savedNum = savedNum * labelDouble
        } else if(currentMode == .division){
            if(labelDouble == 0){
                label.text = "Error"
                return
            }
            savedNum = Double(savedNum / labelDouble)
        } else if(currentMode == .percent){
            savedNum /= 100.0
        } else if(currentMode == .plusMinus){
            savedNum *= -1.0
        }
        currentMode = .not_set
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    @IBAction func didPressClear(_ sender: Any) {
        labelString = ""
        currentMode = .not_set
        savedNum = 0.0
        lastButtonWasMode = false
        label.text = "0"
    }
    
    @IBAction func didPressPercent(_ sender: Any) {
        changeMode(newMode: .percent)
        savedNum /= 100.0;
        label.text = String(savedNum)
        didPressEquals(sender)
    }
    @IBAction func didPressPlusMinus(_ sender: Any) {
       // changeMode(newMode: .plusMinus)
        //converts a non double (string) and converts to double
        guard let labelDouble:Double = Double(labelString) else {
            return
        }
        savedNum = labelDouble * -1
        label.text = String(savedNum)
        labelString = String(savedNum)
        print("\(labelString)")
    }
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue:String? = sender.titleLabel?.text
        if(lastButtonWasMode){
           lastButtonWasMode = false
           labelString = ""
        }
         labelString = labelString.appending(stringValue!)
         updateText()
        
    }
    
    func updateText(){
        if(labelString == "0.0" )
        {
            labelString = "0"
            savedNum = 0
        }
        //converts a non double (string) and converts to double
        guard let labelDouble:Double = Double(labelString) else {
            return
        }
        if(currentMode == .not_set){
            savedNum = labelDouble
        }
        if(currentMode == .plusMinus){
            currentMode = .not_set
            return
        }
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num:NSNumber = NSNumber(value: labelDouble)
        label.text = formatter.string(from: num)
    }
    
    func changeMode(newMode:modes){
        if (savedNum == 0){
           return
        }
        currentMode = newMode
        lastButtonWasMode = true
   }
}

