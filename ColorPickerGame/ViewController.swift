//
//  ViewController.swift
//  ColorPickerGame
//
//  Created by Donovan Cotter Melissa Webster on 9/22/15.
//  Copyright (c) 2015 GrandCircus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    let colorsArray = [
        UIColor(red: 90/255.0, green: 187/255.0, blue: 181/255.0, alpha: 1.0), //teal color
        UIColor(red: 222/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1.0), //yellow color
        UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0), //red color
        UIColor(red: 239/255.0, green: 130/255.0, blue: 100/255.0, alpha: 1.0), //orange color
        UIColor(red: 77/255.0, green: 75/255.0, blue: 82/255.0, alpha: 1.0), //dark color
        UIColor(red: 105/255.0, green: 94/255.0, blue: 133/255.0, alpha: 1.0), //purple color
        UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0), //green color
    ]
    
    var leaderBoardArray = [Int]()
    var timer = NSTimer()
    var seconds = 5
    var computerGuess = UIColor.clearColor()
    var numberGuesses = 0
    var backgroundColorCount = 0
    var winCounter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupGame() {
        numberGuesses = 0
        setComputerGuess()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("changeBackgroundColor"), userInfo: nil, repeats: true)
        
    }
    
    func getRandomColor() -> UIColor {
        let unsignedArrayCount = UInt32(colorsArray.count)
        let unsignedRandomNumber = arc4random_uniform(unsignedArrayCount)
        let randomNumber = Int(unsignedRandomNumber)
    
        return colorsArray[randomNumber]
    }
    
    func changeBackgroundColor() {
        view.backgroundColor = getRandomColor()
        backgroundColorCount++
        if backgroundColorCount == 3 {
            setComputerGuess()
            backgroundColorCount = 0
        }
    }
    
    func setComputerGuess() {
        computerGuess = getRandomColor()
    }
    
    func setupLeaderboard() {
        leaderBoardArray.append(numberGuesses)
        if leaderBoardArray.count > 5 {
            leaderBoardArray.removeFirst()
        }
        
    }
    
    @IBAction func guessButton(sender: AnyObject) {
        numberGuesses++
        
        if computerGuess == view.backgroundColor {
            winCounter++
            setupLeaderboard()
            print(leaderBoardArray)
            let alert = UIAlertController(title: "You Guessed it!", message: "It took you \(numberGuesses) tries.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {action in self.setupGame()}))
            
            presentViewController(alert, animated: true, completion:nil)
            
        } else {
            let alert = UIAlertController(title: "You Got it Wrong", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Keep Playing", style: UIAlertActionStyle.Cancel, handler: nil))
            
            presentViewController(alert, animated: true, completion:nil)
        }
        
    }
    
    

}

