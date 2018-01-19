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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentValue = lroundf(slider.value)
        
        startNewRound()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewRound(){
        
        //reset the slider to the "home" position
        currentValue = 50
        slider.value = Float(currentValue)
        
        //generate a new target
        targetValue = 1 + Int(arc4random_uniform(100))
        
        //increment the round
        round = round + 1
        
        updateLabels()
    }
    
    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
        print("The value of the slider is \(currentValue)")
    }

    @IBAction func showAlert(){
        let message = "The value of the current slider is: \(currentValue)"
        
        let alert = UIAlertController(title: "alert title", message: message, preferredStyle: .alert)
   
        let action = UIAlertAction(title: "action title", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        startNewRound()
    }

}
