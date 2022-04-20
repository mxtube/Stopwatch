//
//  ViewController.swift
//  iTime
//
//  Created by Кирилл Кузнецов on 21.03.2022.
//

import UIKit

class StopWatch: UIViewController {
    
    @IBOutlet weak var time: UIDatePicker!
    @IBOutlet weak var timerLabel: UILabel!
    
    var stopWatch = Timer()
    var playTimer: Bool = false
    
    @IBAction func startAndPauseTimer(_ sender: UIButton) {
        if playTimer {
            changeStartPauseButton(by: sender, "play.fill", text: "Play")
        } else {
            changeStartPauseButton(by: sender, "stop.fill", text: "Stop")
        }
        
    }
    
    func changeStartPauseButton(by button: UIButton, _ image: String, text title: String) {
        playTimer = !playTimer
        button.setTitle(title, for: UIControl.State())
        button.setImage(UIImage(systemName: image), for: UIControl.State())
        
    }
    
}

