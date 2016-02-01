//
//  ViewController.swift
//  retro-calculator
//
//  Created by Yerlan Ismailov on 01.02.16.
//  Copyright © 2016 ismailov.com. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String{
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLable: UILabel!
    var btnSound:AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty;
    var result = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(btn: UIButton){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLable.text = runningNumber
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation){
        playSound()
        if currentOperation != Operation.Empty{
            
            if runningNumber != ""{
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLable.text = result
            }
            
            currentOperation = op
            
        }else{
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
            
        }
        
    }
    
    func playSound(){
        if btnSound.play(){
            btnSound.stop()
        }
        btnSound.play()
    }
    
}

