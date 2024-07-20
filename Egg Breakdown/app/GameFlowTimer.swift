//
//  GameFlowTimer.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/12/24.
//

import Foundation

// https://github.com/indently/CustomCountdownTimer
class GameFlowTimer: ObservableObject {
    @Published var display: String = "0:00"
    var isActive = false
    
    // by seconds
    private let times = GameConfig.times
    private var pointer: Int = -1

    private var endDate = Date()
    private var callOnEnd: (() -> Void)?
    
    private var seconds: Int = 0 {
        didSet {
            display = String(format:"%d:%02d", Int(seconds/60), max(Int(seconds%60), 0))
        }
    }
    
    private func startTimer(seconds: Int) -> Void {
        self.endDate = Date()
        self.endDate = Calendar.current.date(byAdding: .second, value: seconds, to: endDate)!
    }
    
    func updateCountdown() {
        guard isActive else { return }
        
        // Updates the time string with the formatted time
        if seconds == 0 {
            callOnEnd?()
            return
        }
        
        seconds -= 1
    }
    
    func startNext(callOnEnd: @escaping () -> Void) -> Void {
        pointer += 1
        seconds = times[pointer]
        startTimer(seconds: seconds)
        self.callOnEnd = callOnEnd
    }
}
