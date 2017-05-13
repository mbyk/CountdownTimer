//
//  ViewController.swift
//  CountdownTimer
//
//  Created by maru on 2017/05/13.
//  Copyright © 2017年 BlessService. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    var countdownTimer = CountdownTimer(seconds: 10)
    
    @IBAction func startAction() {
        countdownTimer.stop()
        countdownTimer.start()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        countdownTimer.delegate = self
        countdownLabel.text = "initial..."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: CountdownTimerProtocol {
    func updateCountdown(remain: Int) {
        let minites: Int = remain / 60
        let seconds: Int = remain % 60

        if remain > 0 {
            countdownLabel.text = String(format: "%02d:%02d", minites, seconds)
        } else {
            countdownLabel.text = "timeup!"
        }
    }
}
