//
//  ViewController.swift
//  iTime
//
//  Created by Кирилл Кузнецов on 21.03.2022.
//

import UIKit

// Class stopwatch
class StopWatch: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var timerOutput: UILabel!
    @IBOutlet weak var lapResetButton: UIButton!
    @IBOutlet weak var table: UITableView!
    
    var stopWatch: Timer = Timer()
    var counter: Double = 0.0
    var playTimer: Bool = true
    var lapTimer: Bool = true
    var lapList: [String] = []
    
    // Call func when create screen
    override func viewDidLoad() {
        table.delegate = self
        table.dataSource = self
    }
    
    // Event for tapped button start and pause
    @IBAction func startAndPauseTimer(_ sender: UIButton) {
        if playTimer {
            stopWatch = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            changeStartPauseButton(by: sender, "pause.fill", text: "Pause")
            lapResetButton.isEnabled = true
            lapTimer = true
        } else {
            stopWatch.invalidate()
            changeStartPauseButton(by: sender, "play.fill", text: "Play")
            lapTimer = false
            changeLapResetButton(by: lapResetButton, "clear.fill", text: "Reset")
        }
    }
    
    // Selector for timer
    @objc func updateTimer() {
        counter += 0.035
        var minutes: String = "\((Int)(counter / 60))"
        if (Int)(counter / 60) < 10 {
            minutes = "0\((Int)(counter / 60))"
        }
        var seconds: String = String(format: "%.2f", counter.truncatingRemainder(dividingBy: 60))
        if counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        timerOutput.text = minutes + ":" + seconds
    }
    
    // Event for tapped button lap and reset
    @IBAction func lapAndResetTimer(_ sender: UIButton) {
        if lapTimer {
            changeLapResetButton(by: sender, "plus.rectangle.fill", text: "Lap")
            lapList.append(timerOutput.text!)
            table.reloadData()
        } else {
            guard playTimer else { return }
            lapList.removeAll()
            table.reloadData()
            changeLapResetButton(by: sender, "plus.rectangle.fill", text: "Lap")
            sender.isEnabled = false
            timerOutput.text = "00:00"
            counter = 0.0
        }

    }
    
    // Modify view for button start and pause
    func changeStartPauseButton(by button: UIButton, _ image: String, text title: String) {
        playTimer = !playTimer
        button.setTitle(title, for: UIControl.State())
        button.setImage(UIImage(systemName: image), for: UIControl.State())
    }
    
    // Modify view for button lap and reset
    func changeLapResetButton(by button: UIButton, _ image: String, text title: String) {
        button.setTitle(title, for: UIControl.State())
        button.setImage(UIImage(systemName: image), for: UIControl.State())
    }
    
    // Function for count row in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapList.count
    }
    
    // Function for configure cell in table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableRow", for: indexPath) as! TableCell
        cell.tableLabel.text = lapList[indexPath.row]
        return cell
    }
}

