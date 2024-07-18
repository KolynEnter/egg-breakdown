//
//  GameConfig.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/12/24.
//

import Foundation

struct GameConfig {
    private static let config: [(GamePhase, Int)] = [
        (GamePhase.setupDefense,    30),
        (GamePhase.attack,          30),
        (GamePhase.attack,          30),
        (GamePhase.reveal,          3),
        (GamePhase.newRound,        0),
        (GamePhase.setupDefense,    30),
        (GamePhase.attack,          30),
        (GamePhase.attack,          30),
        (GamePhase.reveal,          3),
        (GamePhase.newRound,        0),
        (GamePhase.setupDefense,    30),
        (GamePhase.attack,          30),
        (GamePhase.attack,          30),
        (GamePhase.reveal,          3),
        (GamePhase.gameEnd,         0)
    ]
    
    static var gameFlow: [GamePhase] {
        get {
            return config.map {$0.0}
        }
    }
    
    static var times: [Int] {
        get {
            return config.map {$0.1}
        }
    }
}
