//
//  Game.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import Foundation
import AVFoundation

class EggBreakdownGame: ObservableObject {
    
    // Hack: Set player's eggs for now, not multi-player yet
    @Published var coverAlphaValues: [Double] = [0, 0, 0, 0, 1, 1, 1, 1]
    @Published var dropZoneEggType: [EggType] = Array(repeating: EggType.normal, count: 8)
    @Published var isZoneTargeted:     [Bool] = Array(repeating: false,          count: 8)
    @Published private(set) var gamePhase: GamePhase
    // Current Round of the game (1, 2, 3; game ends after Round 3)
    @Published var round: Int = 1
    @Published private(set) var popupControl: PopupHelper
    @Published var gameFlowTimer: GameFlowTimer
    
    var eggCupFrames: [CGRect] = Array(repeating: .zero, count: 8)

    private let p1: Player
    private let p2: Player
    private let turnManager: TurnManager
    var turnOwner: Player? {
        get {
            return turnManager.turnOwner
        }
    }
    var hasGameEnd: Bool = false

    init(player1: Player, player2: Player) {
        popupControl = PopupHelper()
        
        self.p1 = player1
        self.p2 = player2
        
        gameFlowTimer = GameFlowTimer()
        
        let order = [p1, p2].shuffled()
        turnManager = TurnManager(firstHandPlayer: order[0], secondHandPlayer: order[1])
        
        gamePhase = turnManager.getCurrPhase()
        
        p1.setGame(gameToPlayer: GameToPlayer(game: self,
                                              gameBreakEgg: breakEgg,
                                              endAttackTurn: endAttackTurn))
        p2.setGame(gameToPlayer: GameToPlayer(game: self,
                                              gameBreakEgg: breakEgg,
                                              endAttackTurn: endAttackTurn))
        
        startSetupDefenseTurn()
        
        gameFlowTimer.startNext(callOnEnd: goToNextGamePhase)
    }
    
    func popup(message: String) -> Void {
        popupControl.showPopup = true
        popupControl.message = message
    }
    
    func popout() -> Void {
        popupControl.showPopup = false
        popupControl.message = ""
    }
    
    func getLocalPlayer() -> Player {
        return p1
    }
    
    func getOtherPlayer() -> Player {
        return p2
    }
    
    func endSetupDefenseTurn() -> Void {
        if p1.isSetupReady && p2.isSetupReady {
            p1.isSetupReady = false
            p2.isSetupReady = false
            goToNextGamePhase()
        }
    }
    
    private func endAttackTurn() -> Void {
        if turnManager.getCurrPhase() == .attack {
            goToNextGamePhase()
        }
    }
    
    func updateCountdown() -> Void {
        gameFlowTimer.updateCountdown()
    }
    
    func isLocalPlayerFirst() -> Bool {
        return turnManager.isPlayerFirst(player: getLocalPlayer())
    }
    
    private func breakEgg(at zoneIndex: Int) -> Void {
        if dropZoneEggType[zoneIndex] == EggType.normal {
            coverAlphaValues[zoneIndex] = 0
            dropZoneEggType[zoneIndex] = EggType.broken
//            print("BROKE A NORMAL EGG.")
            SoundManager.shared.playSFX(sfxName: "hit_egg", extension: "mp3")
            turnManager.turnOwner?.incrementScore()
        } else if dropZoneEggType[zoneIndex] == EggType.golden {
            coverAlphaValues[zoneIndex] = 0
            SoundManager.shared.playSFX(sfxName: "hit_golden_egg", extension: "mp3")
//            print("IT'S A GOLDEN EGG!")
        } else {
            
        }
    }
    
    private func startSetupDefenseTurn() -> Void {
        p1.startSetupDefenseTurn()
        p2.startSetupDefenseTurn()
    }
    
    private func refresh() -> Void {
        dropZoneEggType = Array(repeating: EggType.normal, count: 8)
        coverAlphaValues = [0, 0, 0, 0, 1, 1, 1, 1]
    }
    
    private func goToNextGamePhase() -> Void {
        if hasGameEnd { return }

        gamePhase = turnManager.goToNextPhase()
        gameFlowTimer.startNext(callOnEnd: goToNextGamePhase)
        
        turnManager.start()
        
        if turnManager.getCurrPhase() == .attack &&
            ((p1.isSetupReady && !p2.isSetupReady) ||
             (p2.isSetupReady && !p1.isSetupReady))  {
            p1.isSetupReady = false
            p2.isSetupReady = false
            coverAlphaValues = [0.5, 0.5, 0.5, 0.5, 1, 1, 1, 1]
        }
        else if turnManager.getCurrPhase() == .newRound {
            round += 1
        } 
        else if turnManager.getCurrPhase() == .reveal {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                self.coverAlphaValues = [0, 0, 0, 0, 0, 0, 0, 0]
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [self] in
                if self.getOtherPlayer() is RobotPlayer {
                    (getOtherPlayer() as! RobotPlayer).revealNumOfGoldenEggs()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [self] in
                if self.round + 1 == 4 { return }
                self.refresh()
                self.goToNextGamePhase()
            }
        } 
        else if turnManager.getCurrPhase() == .gameEnd {
            hasGameEnd = true
            
            // Game end
            popupControl.showPopup = true
            let localScore = getLocalPlayer().score
            let otherScore = getOtherPlayer().score
            let localGoldenEggs = getLocalPlayer().numOfGoldenEggs
            let otherGoldenEggs = getOtherPlayer().numOfGoldenEggs
            if localScore > otherScore {
                // You won
                popupControl.message = "You won!"
            } else if localScore == otherScore {
                if localGoldenEggs > otherGoldenEggs {
                    // You won
                    popupControl.message = "You won!"
                } else if localGoldenEggs == otherGoldenEggs {
                    // It's a tie
                    popupControl.message = "It's a tie!"
                } else {
                    // You lose
                    popupControl.message = "You lose..."
                }
            } else {
                // You lose
                popupControl.message = "You lose..."
            }
            popupControl.isGoToMain = true
        }
    }
}
