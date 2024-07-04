//
//  Game.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import Foundation

class EggBreakdownGame: ObservableObject {
    private let NUM_OF_PLAYERS: Int = 2
    
    // Hack: Set player's eggs for now, not multi-player yet
    @Published var coverAlphaValues: [Double] = [0, 0, 0, 0, 1, 1, 1, 1]
    @Published var dropZoneEggType: [EggType] = Array(repeating: EggType.normal, count: 8)
    @Published var isZoneTargeted:     [Bool] = Array(repeating: false,          count: 8)
    @Published private(set) var gamePhase: GamePhase
    // If nil, it's a turn for both players
    @Published private(set) var turnOwnerId: UUID? = nil
    // Current Round of the game (1, 2, 3; game ends after Round 3)
    @Published var round: Int = 1

    var eggCupFrames: [CGRect] = Array(repeating: .zero, count: 8)

    private let p1: Player
    private let p2: Player
    // Who currently owns this attack turn,
    // nil if not in an attack turn
    private let gameFlowController = GameFlowController()
    private var setupReadyPlayerIDs: [UUID] = []
    
    init(player1: Player, player2: Player) {
        self.p1 = player1
        self.p2 = player2
        
        gamePhase = gameFlowController.getCurrPhase()
        
        p1.setGame(gameToPlayer: GameToPlayer(game: self,
                                              gameBreakEgg: breakEgg,
                                              endAttackTurn: endAttackTurn))
        p2.setGame(gameToPlayer: GameToPlayer(game: self,
                                              gameBreakEgg: breakEgg,
                                              endAttackTurn: endAttackTurn))
        startSetupDefenseTurn()
        
        turnOwnerId = p1.id
    }
    
    func getLocalPlayer() -> Player {
        return p1
    }
    
    func getOtherPlayer() -> Player {
        return p2
    }
    
    func exitSetupDefenseTurn(id: UUID) -> Void {
        func getName() -> String {
            return id == getLocalPlayer().id ? getLocalPlayer().name : getOtherPlayer().name
        }
        
        if !setupReadyPlayerIDs.contains(id) {
            setupReadyPlayerIDs.append(id)
            print("The ids \(setupReadyPlayerIDs)")
            print("\(getName()) is ready")
        }
        
        if setupReadyPlayerIDs.count == NUM_OF_PLAYERS {
            turnOwnerId = p1.id // make p1 first-hand
            goToNextGamePhase()
            setupReadyPlayerIDs.removeAll()
        }
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
    
    private func endAttackTurn() -> Void {
        if gameFlowController.getCurrPhase() == GamePhase.attack {
            turnOwnerId = getOtherId()
            print("Give turn to \(getTurnOwner().name).")
//            startAttackTurn()
            goToNextGamePhase()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.refresh()
                self.turnOwnerId = nil
                self.goToNextGamePhase()
            }
        }
    }
    
    private func decideWhoWillAttack() -> Void {
        if turnOwnerId != p1.id {
            turnOwnerId = p1.id
        } else {
            turnOwnerId = p2.id
        }
    }
    
    private func startAttackTurn() -> Void {
//        decideWhoWillAttack()
        getTurnOwner().startAttackTurn()
    }
    
    private func addScoreToAttacker() -> Void {
        getTurnOwner().incrementScore()
    }
    
    private func startSetupDefenseTurn() -> Void {
        p1.startSetupDefenseTurn()
        p2.startSetupDefenseTurn()
    }
    
    private func refresh() -> Void {
        dropZoneEggType = Array(repeating: EggType.normal, count: 8)
        coverAlphaValues = [0, 0, 0, 0, 1, 1, 1, 1]
    }
    
    private func getOtherId() -> UUID? {
        if turnOwnerId == nil {
            return nil
        }
        if turnOwnerId == getLocalPlayer().id {
            return getOtherPlayer().id
        } else {
            return getLocalPlayer().id
        }
    }
    
    private func getTurnOwner() -> Player {
        return turnOwnerId == getLocalPlayer().id ? getLocalPlayer() : getOtherPlayer()
    }
    
    private func goToNextGamePhase() -> Void {
        gameFlowController.advanceFlow()
        gamePhase = gameFlowController.getCurrPhase()
        
        if gameFlowController.getCurrPhase() == GamePhase.attack {
            startAttackTurn()
        } else if gameFlowController.getCurrPhase() == GamePhase.setupDefense {
            startSetupDefenseTurn()
        } else if gameFlowController.getCurrPhase() == GamePhase.newRound {
            round += 1
//            goToNextGamePhase()
        }
    }
}

fileprivate class GameFlowController {
    private let gameFlow = [GamePhase.setupDefense,
//                            GamePhase.sendMessage,
                            GamePhase.attack,
                            GamePhase.attack,
                            GamePhase.newRound,
                            GamePhase.setupDefense,
//                            GamePhase.sendMessage,
                            GamePhase.attack,
                            GamePhase.attack,
                            GamePhase.newRound,
                            GamePhase.setupDefense,
//                            GamePhase.sendMessage,
                            GamePhase.attack,
                            GamePhase.attack,
                            GamePhase.newRound,
                            GamePhase.setupDefense]
    private var flowPointer: Int = 0
    
    func getCurrPhase() -> GamePhase {
        return gameFlow[flowPointer]
    }
    
    func advanceFlow() -> Void {
        flowPointer += 1
        print("Flow pointer \(flowPointer): \(gameFlow[flowPointer])")
    }
}
