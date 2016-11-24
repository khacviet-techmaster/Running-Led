 //
 //  ViewController.swift
 //  On Off Led
 //
 //  Created by khacviet on 11/22/16.
 //  Copyright © 2016 khacviet. All rights reserved.
 //
 
 import UIKit
 
 class ViewController: UIViewController
 {
    
    @IBOutlet weak var conditionX: UITextField!
    
    @IBOutlet weak var conditionY: UITextField!
    
    var x = 0
    var y = 0
    
    let widthMargin = 30
    let heightMargin = 70
    
    var lastOnLed = -1
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(runningLed), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func DrawLED(sender: AnyObject)
    {
        for subview in self.view.subviews
        {
            if subview.tag >= 100
            {
                subview.removeFromSuperview()
            }
        }
        if checkCondition() == true
        {
            draw()
            //            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(runningLed), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func startRun(sender: AnyObject)
    {
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(runningLed), userInfo: nil, repeats: true)
    }
    
    
    func checkCondition() -> Bool
    {
        if Int(conditionX.text!) == nil  //|| Int(conditionY.text!) == nil
        {
            return false
        }
        return true
    }
    
    func draw()
    {
        x = Int(conditionX.text!)!
        y = Int(conditionY.text!)!
        
        for indexX in 0..<x
        {
            for indexY in 0..<y
            {
                let image = UIImage(named: "grey")
                let greenLED = UIImageView(image: image)
                greenLED.center = CGPointMake(CGFloat(widthMargin) + (CGFloat(indexX) * setWidth()),
                                              CGFloat(heightMargin) + (CGFloat(indexY) * setHeight()))
                greenLED.tag = indexY + 100
                self.view.addSubview(greenLED)
            }
        }
    }
    
    func setWidth() -> CGFloat
    {
        let a = self.view.bounds.size.width
        var widthSpace:CGFloat = 0
        if conditionX.text! == "1"
        {
            widthSpace = 0
        }
        else
        {
            widthSpace = (a - (CGFloat(widthMargin) * 2)) / (CGFloat(x) - 1)
        }
        return widthSpace
    }
    
    func setHeight() -> CGFloat
    {
        let b = self.view.bounds.size.height
        var heightSpace: CGFloat = 0
        if conditionX.text! == "1"
        {
            heightSpace = 0
        }
        else
        {
            heightSpace = (b - (CGFloat(heightMargin) * 2)) / (CGFloat(y) - 1)
        }
        return heightSpace
    }
    
    func runningLed()
    {
        if checkLocation == true
        {
            runningLedRight()
        }
        if checkLocation == false
        {
            runningLedLeft()
        }
    }
    
    var checkLocation = true
    
    func runningLedRight()
    {
        if lastOnLed == 0
        {
            turnOnLed()
        }
        if lastOnLed != y - 1
        {
            turnOffLed()
            lastOnLed = lastOnLed + 1
            turnOnLed()
        }
        else
        {
            lastOnLed = y - 1
            turnOnLed()
            checkLocation = false
        }
    }
    
    func runningLedLeft()
    {
        if lastOnLed == y - 1
        {
            turnOffLed()
            lastOnLed = lastOnLed - 1
        }
        else if lastOnLed != y - 1
        {
            turnOffLed()
            lastOnLed = lastOnLed - 1
        }
        if lastOnLed == 0
        {
            lastOnLed = 0
            checkLocation = true
        }
        turnOnLed()
    }
    
    func turnOnLed()
    {
        if let greenLED = self.view.viewWithTag(100 + lastOnLed)
            as? UIImageView
        {
            greenLED.image = UIImage(named: "green")
        }
    }
    
    func turnOffLed()
    {
        if let greenLED = self.view.viewWithTag(100 + lastOnLed)
            as? UIImageView
        {
            greenLED.image = UIImage(named: "grey")
        }
    }
 }
 
