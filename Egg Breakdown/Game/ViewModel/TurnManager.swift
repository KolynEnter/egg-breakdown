//
//  TurnManager.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/16/24.
//

import Foundation

class TurnManager {
    private let first_HandPlayer: Player
    private let secondHandPlayer: Player
    private var setupReadyPlayerIDs: [UUID] = []
    private let flowController = FlowController()
    
    private var turnOwnerArray: [Player?] = []
    var turnOwner: Player? {
        get {
            if turnOwnerArray.count == 0 {
                turnOwnerArray = getTurnOwnerArray()
            }
            return turnOwnerArray[flowController.pointer]
        }
    }
    
    init(firstHandPlayer: Player, secondHandPlayer: Player) {
        self.first_HandPlayer = firstHandPlayer
        self.secondHandPlayer = secondHandPlayer
    }
    
    func startSetupDefenseTurn() -> Void {
        first_HandPlayer.startSetupDefenseTurn()
        secondHandPlayer.startSetupDefenseTurn()
    }
    
    func startAttackTurn() -> Void {
        turnOwner?.startAttackTurn()
    }
    
    func goToNextPhase() -> GamePhase {
        flowController.advanceFlow()
        return flowController.getCurrPhase()
    }
    
    func start() -> Void {
        if flowController.getCurrPhase() == .setupDefense {
            startSetupDefenseTurn()
        }
        else if flowController.getCurrPhase() == .attack {
            startAttackTurn()
        }
    }
    
    func getCurrPhase() -> GamePhase {
        return flowController.getCurrPhase()
    }
    
    func isPlayerFirst(player: Player) -> Bool {
        return first_HandPlayer.id == player.id
    }
    
    /// Get an array of turn owners during this game according to the flow pointer.
    /// Only during an attack turn there is a turn owner, otherwise nil.
    ///
    /// - Returns: The list of  turn owners during this game.
    private func getTurnOwnerArray() -> [Player?] {
        var counter = 0
        func convertor(phase: GamePhase) -> Player? {
            if phase == .attack {
                if counter % 2 == 0 {
                    counter += 1
                    return first_HandPlayer
                }
                else {
                    counter += 1
                    return secondHandPlayer
                }
            }
            return nil
        }
        
        let gameFlow = GameConfig.gameFlow
        return gameFlow.map(convertor)
    }
}

fileprivate class FlowController {
    private let flow = GameConfig.gameFlow
    private(set) var pointer: Int = 0
    
    func getCurrPhase() -> GamePhase {
        return flow[pointer]
    }
    
    func advanceFlow() -> Void {
        pointer += 1
    }
}
