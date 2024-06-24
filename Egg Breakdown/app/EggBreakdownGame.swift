//
//  Game.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

class EggBreakdownGame {
    let player1: Player
    let player2: Player
    // Current Round of the game (1, 2, 3; game ends after Round 3)
    var round: Int = 1
    private var gamePhase: GamePhase = GamePhase.setupDefense
    
    
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
    }
    
    func getGamePhase() -> GamePhase {
        return gamePhase
    }
    
    
}
