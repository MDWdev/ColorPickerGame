//
//  ViewController.swift
//  ColorPickerGame
//
//  Created by Donovan Cotter Melissa Webster on 9/22/15.
//  Copyright (c) 2015 GrandCircus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlet for Leaderboard label, which will eventually show last 5 games scores
    @IBOutlet weak var leaderboardLabel: UILabel!
    
    // Our color array to hold the background
    let colorsArray = [
        UIColor(red: 90/255.0, green: 187/255.0, blue: 181/255.0, alpha: 1.0), //teal color
        UIColor(red: 222/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1.0), //yellow color
        UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0), //red color
        UIColor(red: 239/255.0, green: 130/255.0, blue: 100/255.0, alpha: 1.0), //orange color
        UIColor(red: 77/255.0, green: 75/255.0, blue: 82/255.0, alpha: 1.0), //dark color
        UIColor(red: 105/255.0, green: 94/255.0, blue: 133/255.0, alpha: 1.0), //purple color
        UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0), //green color
    ]
    
    // Variable declarations
    var leaderBoardArray = [Int]()
    var timer = NSTimer()
    var computerGuess = UIColor.clearColor()
    var numberGuesses = 0
    var backgroundColorCount = 0
    var winCounter = 0
    
    // The default viewDidLoad function. We added the function call to setupGame here
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
    }
    
    // This function resets our number of guesses to 0
    // It then calls the function to set the Computer's Guess
    // And then sets up our timer - within the timer, we call the function to change the background color
    func setupGame() {
        numberGuesses = 0
        setComputerGuess()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("changeBackgroundColor"), userInfo: nil, repeats: true)
        
    }
    
    // We borrowed function this from FunFacts in order to pick our random colors
    func getRandomColor() -> UIColor {
        let unsignedArrayCount = UInt32(colorsArray.count)
        let unsignedRandomNumber = arc4random_uniform(unsignedArrayCount)
        let randomNumber = Int(unsignedRandomNumber)
    
        return colorsArray[randomNumber]
    }
    
    // This function calls the random color function and changes the background color to it
    // It then incremements our Background color counter (in order to allow the computer
    // to guess a new color after 3 changes
    func changeBackgroundColor() {
        view.backgroundColor = getRandomColor()
        backgroundColorCount++
        if backgroundColorCount == 3 {
            setComputerGuess()
            backgroundColorCount = 0
        }
    }
    
    
    // This function simply calls the random color function to set a random color to
    // the computer's guess
    func setComputerGuess() {
        computerGuess = getRandomColor()
    }
    
    
    // This function sets up our leaderboard array, which stores the latest 5
    // games value for "Number of Guesses"
    // Once the array has 6 values in it, it deletes the value at index 0
    func setupLeaderboard() {
        leaderBoardArray.append(numberGuesses)
        if leaderBoardArray.count > 5 {
            leaderBoardArray.removeFirst()
        }
        
    }
    
    
    
    // Once the user pushes the button -
    // Increment the "Number of Guesses" counter
    @IBAction func guessButton(sender: AnyObject) {
        numberGuesses++
        
        // if the stored computer color is the same as the background color...
        // increment the counter for # of wins
        // call the leaderboard function which will display our latest 5 games scores
        if computerGuess == view.backgroundColor {
            timer.invalidate()
            winCounter++
            setupLeaderboard()
            print(leaderBoardArray) //we are printing this to test what is stored in the array
            
            // print the array values
            leaderboardLabel.text = "\(leaderBoardArray)"
            
            // this sets up the alert when the user wins
            // the alert action then calls the setup Game function to start over again
            let alert = UIAlertController(title: "You Guessed it!", message: "It took you \(numberGuesses) tries.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {action in self.setupGame()}))
            // the following is what makes the WON alert pop up
            presentViewController(alert, animated: true, completion:nil)
            
        } else {
            
            // this sets up the alert for when the user is incorrect
            let alert = UIAlertController(title: "You Got it Wrong", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Keep Playing", style: UIAlertActionStyle.Cancel, handler: nil))
            // the following is what makes the WRONG alert pop up
            presentViewController(alert, animated: true, completion:nil)
        }
        
    
        
    }
    
    

}

