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
    
    private func start(seconds: Int) -> Void {
        self.endDate = Date()
        self.isActive = true
        self.endDate = Calendar.current.date(byAdding: .second, value: seconds, to: endDate)!
    }
    
    func updateCountdown() {
        guard isActive else { return }
        
//        // Gets the current date and makes the time difference calculation
//        let now = Date()
//        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
//        
//        
//        // Checks that the countdown is not <= 0
//        if diff <= 0 {
//            self.isActive = false
//            self.display = "0:00"
//            //            self.showingAlert = true
//            return
//        }
//        
//        // Turns the time difference calculation into sensible data and formats it
//        let date = Date(timeIntervalSince1970: diff)
//        let calendar = Calendar.current
//        let minutes = calendar.component(.minute, from: date)
//        let seconds = calendar.component(.second, from: date)

        // Updates the time string with the formatted time
        if seconds == 0 {
            callOnEnd?()
            callOnEnd = nil
            return
        }
        
        seconds -= 1
    }
    
    func startNext(callOnEnd: @escaping () -> Void) -> Void {
        pointer += 1
        seconds = times[pointer]
        print("Seconds \(seconds)")
        start(seconds: seconds)
        self.callOnEnd = callOnEnd
    }
}
