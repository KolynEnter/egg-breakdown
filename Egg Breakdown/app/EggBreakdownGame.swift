//
//  Game.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import Foundation

class EggBreakdownGame: ObservableObject {
    @Published var coverAlphaValues: [Double] = Array(repeating: 1.0,            count: 8)
    @Published var dropZoneEggType: [EggType] = Array(repeating: EggType.normal, count: 8)
    @Published var isZoneTargeted:     [Bool] = Array(repeating: false,          count: 8)
    @Published var localGoldenEggs: Int = 8
    @Published var rivalGoldenEggs: Int = 8
    // Current Round of the game (1, 2, 3; game ends after Round 3)
    @Published var round: Int = 1
    
    let player1: Player
    let player2: Player
    private var gamePhase: GamePhase = GamePhase.setupDefense
    
    
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
        
        // Hack: Set player's eggs for now, not multi-player yet
        coverAlphaValues[0] = 0
        coverAlphaValues[1] = 0
        coverAlphaValues[2] = 0
        coverAlphaValues[3] = 0
        
        dropZoneEggType[7] = EggType.golden
    }
    
    func getGamePhase() -> GamePhase {
        return gamePhase
    }
    
    func breakEgg(at zoneIndex: Int) -> Void {
        if dropZoneEggType[zoneIndex] == EggType.normal {
            coverAlphaValues[zoneIndex] = 0
            dropZoneEggType[zoneIndex] = EggType.broken
        } else if dropZoneEggType[zoneIndex] == EggType.golden {
            coverAlphaValues[zoneIndex] = 0
        } else {
            
        }
    }
}
