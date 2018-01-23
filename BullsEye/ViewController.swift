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
    @IBOutlet weak var slider: UISlider!

    var targetValue: Int = 0
    @IBOutlet weak var targetLabel: UILabel!
    
    var score: Int = 0
    @IBOutlet weak var scoreLabel: UILabel!

    var round: Int = 0
    @IBOutlet weak var roundLabel: UILabel!
    
    var difference: Int = 0

    
    //--------------------------------------------------------------------------------
    // Method that runs on load of app
    //--------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        initApp()
    }

    
    
    
    //--------------------------------------------------------------------------------
    // Initialize the app to the starting values
    //--------------------------------------------------------------------------------
    func initApp() {
        initSlider()
        initTarget()
        updateRound(isStartOver: true)
        updateScore(isStartOver: true)
        styleTheSlider()
    }

    
    //--------------------------------------------------------------------------------
    // Style the Slider
    //--------------------------------------------------------------------------------
    func styleTheSlider() {
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlight = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlight, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftImageResizeable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftImageResizeable, for: .normal)

        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightImageResizeable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightImageResizeable, for: .normal)
    }

    
    //--------------------------------------------------------------------------------
    // Get the game ready to play a new round
    //--------------------------------------------------------------------------------
    func startNewRound() {
        updateRound(isStartOver: false)
        updateScore(isStartOver: false)
        initSlider()
        initTarget()
    }

    
    //--------------------------------------------------------------------------------
    // Move the slider back to the "home" position
    //--------------------------------------------------------------------------------
    func initSlider() {
        currentValue = 50
        slider.value = Float(currentValue)
    }

    
    //--------------------------------------------------------------------------------
    // Generate a target value
    //--------------------------------------------------------------------------------
    func initTarget() {
        targetValue = 1 + Int(arc4random_uniform(100))
        targetLabel.text = String(targetValue)
    }
    
    
    //--------------------------------------------------------------------------------
    // Update the round
    //--------------------------------------------------------------------------------
    func updateRound(isStartOver: Bool) {
        if isStartOver {
            round = 1
        } else {
            round = round + 1
        }
        roundLabel.text = String(round)
    }

    
    //--------------------------------------------------------------------------------
    // Update the score
    //--------------------------------------------------------------------------------
    func updateScore(isStartOver: Bool) {
        if isStartOver {
            score = 0
        } else {
            if difference == 0 {
                score = score + 100
            } else if difference < 5 {
                score = score + difference + 50
            } else if difference < 10 {
                score = score + difference + 10
            } else {
                score = score + 1
            }
        }
        
        scoreLabel.text = String(score)
    }

    
    //--------------------------------------------------------------------------------
    // Determine the appropriate message for the player
    //--------------------------------------------------------------------------------
    func determineTitle() -> String {
        if difference == 0 {
            return "BULLS EYE!!!!"
        } else if difference < 5 {
            return "Pretty Close, Good Job!!"
        } else if difference < 10 {
            return "Well, at least you tried."
        } else {
            return "Dude, not even close!"
        }
    }
    
    
    //--------------------------------------------------------------------------------
    // Player moves the slider
    //--------------------------------------------------------------------------------
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }

    
    //--------------------------------------------------------------------------------
    // Player taps "Start Over" Button
    //--------------------------------------------------------------------------------
    @IBAction func resetGame() {
        initApp()
    }

    
    //--------------------------------------------------------------------------------
    // Player taps "Hit Me" Button
    //--------------------------------------------------------------------------------
    @IBAction func showAlert() {
        
        difference = abs(targetValue - currentValue)
        
        let title = determineTitle()

        let message = "The target was: \(targetValue)" +
            "\nYou moved the slider to: \(currentValue)" +
            "\nThe difference is: \(difference)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "Start a New Round", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
        
    }
    

    //--------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
