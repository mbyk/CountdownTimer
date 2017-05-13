//
//  CountdownTimer.swift
//  CountdownTimer
//
//  Created by maru on 2017/05/13.
//

import Foundation

protocol CountdownTimerProtocol: class {
    func updateCountdown(remain: Int)
}

class CountdownTimer {
    weak var delegate: CountdownTimerProtocol?
    var timer: DispatchSourceTimer?
    let seconds: Int
    var startTime: UInt64 = 0
    
    init(seconds: Int) {
        self.seconds = seconds
    }
    
    func start() {
        startTime = mach_absolute_time()
        let queue = DispatchQueue(label: "com.app.timer", attributes: .concurrent)
        timer?.cancel()
        
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.scheduleRepeating(deadline: .now(), interval: .seconds(1), leeway: .seconds(1))
        timer?.setEventHandler { [weak self] in
            guard let weakSelf = self else { return }
            
            let currentTime: UInt64 = mach_absolute_time()
            let diff = currentTime - weakSelf.startTime
            DispatchQueue.main.async {
                self?.delegate?.updateCountdown(remain: max(weakSelf.seconds - Int(diff/1000000000), 0))
            }

        }
        timer?.resume()
    }
    
    func stop() {
        timer?.cancel()
        timer = nil
    }
}
