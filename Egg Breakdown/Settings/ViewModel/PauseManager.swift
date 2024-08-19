//
//  PauseManager.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/19/24.
//

import Foundation

class PauseManager {
    @Published private var gameFlowTimer: GameFlowTimer
    
    private var locks: Set<String> = Set()
    var isPaused: Bool {
        get {
            return locks.count > 0
        }
    }
    
    init(gameFlowTimer: GameFlowTimer) {
        self.gameFlowTimer = gameFlowTimer
    }
    
    func pause(lock: String) -> Void {
        locks.insert(lock)
        gameFlowTimer.isActive = false
    }
    
    func unpause(lock: String) -> Void {
        locks.remove(lock)
        
        if locks.count == 0 {
            gameFlowTimer.isActive = true
        }
    }
}
