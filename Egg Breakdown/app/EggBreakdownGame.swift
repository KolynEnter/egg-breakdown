//
//  Game.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import Foundation

class EggBreakdownGame: ObservableObject {
    // Hack: Set player's eggs for now, not multi-player yet
    @Published var coverAlphaValues: [Double] = [0, 0, 0, 0, 1, 1, 1, 1]
    @Published var dropZoneEggType: [EggType] = Array(repeating: EggType.normal, count: 8)
    @Published var isZoneTargeted:     [Bool] = Array(repeating: false,          count: 8)
    @Published private(set) var gamePhase: GamePhase = GamePhase.setupDefense
    // Current Round of the game (1, 2, 3; game ends after Round 3)
    @Published var round: Int = 1

    private let p1: Player
    private let p2: Player
    private var hasOnePlayerAttackedThisRound: Bool = false
    // Who currently owns this attack turn,
    // nil if not in an attack turn
    private(set) var attackTurnOwnerID: UUID? = nil
    
    init(player1: Player, player2: Player) {
        self.p1 = player1
        self.p2 = player2

        p1.setGame(gameToPlayer: GameToPlayer(game: self,
                                              gameBreakEgg: breakEgg,
                                              endAttackTurn: endAttackTurnFor))
        p2.setGame(gameToPlayer: GameToPlayer(game: self,
                                              gameBreakEgg: breakEgg,
                                              endAttackTurn: endAttackTurnFor))
        startSetupDefenseTurn()
    }
    
    func getLocalPlayer() -> Player {
        return p1
    }
    
    func getOtherPlayer() -> Player {
        return p2
    }
    
    func goToAttackPhase() -> Void {
        gamePhase = GamePhase.attack
        decideWhoWillAttack()
        startAttackTurn()
    }
    
    private func breakEgg(at zoneIndex: Int) -> Void {
        if dropZoneEggType[zoneIndex] == EggType.normal {
            coverAlphaValues[zoneIndex] = 0
            dropZoneEggType[zoneIndex] = EggType.broken
            
            print("BROKE A NORMAL EGG.")
            addScoreToAttacker()
        } else if dropZoneEggType[zoneIndex] == EggType.golden {
            coverAlphaValues[zoneIndex] = 0
            print("IT'S A GOLDEN EGG!")
        } else {
            
        }
    }
    
    private func endAttackTurnFor(player: Player) -> Void {
        if !hasOnePlayerAttackedThisRound {
            // Give turn to opponent
            attackTurnOwnerID = attackTurnOwnerID == nil ?
                                    p1.id :
                                attackTurnOwnerID == p1.id ?
                                    p2.id : p1.id
            print("Give turn to \(String(describing: attackTurnOwnerID?.uuidString)).")
            
            startAttackTurn()
            hasOnePlayerAttackedThisRound = true
        } else {
            hasOnePlayerAttackedThisRound = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.gamePhase = GamePhase.setupDefense
                self.startSetupDefenseTurn()
                self.refresh()
                self.attackTurnOwnerID = nil
                self.round += 1
            }
        }
    }
    
    private func decideWhoWillAttack() -> Void {
        attackTurnOwnerID = p1.id
    }
    
    private func startAttackTurn() -> Void {
        attackTurnOwnerID == p1.id ? p1.startAttackTurn() : p2.startAttackTurn()
    }
    
    private func addScoreToAttacker() -> Void {
        attackTurnOwnerID == p1.id ? p1.incrementScore() : p2.incrementScore()
    }
    
    private func startSetupDefenseTurn() -> Void {
        p1.startSetupDefenseTurn()
        p2.startSetupDefenseTurn()
    }
    
    private func refresh() -> Void {
        dropZoneEggType = Array(repeating: EggType.normal, count: 8)
        coverAlphaValues = [0, 0, 0, 0, 1, 1, 1, 1]
    }
}
