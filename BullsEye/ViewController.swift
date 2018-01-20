//
//  ViewController.swift
//  BullsEye
//
//  Created by Oval Frame on 1/18/18.
//  Copyright © 2018 Oval Frame. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    
    //--------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
    }

    
    //--------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //--------------------------------------------------------------------------------
    // Get the game ready to play a round
    //--------------------------------------------------------------------------------
    func startNewRound() {
        resetSlider()
        chooseATarget()
        updateRound()
        updateScore()
    }

    
    //--------------------------------------------------------------------------------
    // Move the slider back to the "home" position
    //--------------------------------------------------------------------------------
    func resetSlider() {
        currentValue = 50
        slider.value = Float(currentValue)
    }

    
    //--------------------------------------------------------------------------------
    // Generate a new target value
    //--------------------------------------------------------------------------------
    func chooseATarget() {
        targetValue = 1 + Int(arc4random_uniform(100))
        targetLabel.text = String(targetValue)
    }
    
    //--------------------------------------------------------------------------------
    // Update the round
    //--------------------------------------------------------------------------------
    func updateRound() {
        round = round + 1
        roundLabel.text = String(round)
    }

    
    //--------------------------------------------------------------------------------
    // Update the score
    //--------------------------------------------------------------------------------
    func updateScore() {
        
        if round >= 2 {
            let difference = abs(currentValue - targetValue)
            
            if difference == 0 {
                score = score + 1000
            } else {
                score = score + difference
            }
        } else {
            score = 0
        }
        
        scoreLabel.text = String(score)
    }

    
    //--------------------------------------------------------------------------------
    // Determine if the user it a bulls eye
    //--------------------------------------------------------------------------------
    func isBullsEye() -> String {
        if currentValue == targetValue {
            return "BULLS EYE!!!"
        } else {
            return "NOPE"
        }
    }
    
    
    //--------------------------------------------------------------------------------
    // Customer moves the slider
    //--------------------------------------------------------------------------------
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }

    
    //--------------------------------------------------------------------------------
    // Customer taps "Start Over" Button
    //--------------------------------------------------------------------------------
    @IBAction func resetGame() {
        round = 0
        updateRound()
        
        score = 0
        updateScore()
    }

    
    //--------------------------------------------------------------------------------
    // Customer taps "Hit Me" Button
    //--------------------------------------------------------------------------------
    @IBAction func showAlert() {
        let title = isBullsEye()
        let message = "The value of the current slider is: \(currentValue)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "Start a New Round", style: .default, handler: nil)
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
        
        startNewRound()
    }
    
    
}
