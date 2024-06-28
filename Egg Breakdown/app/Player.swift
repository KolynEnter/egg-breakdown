//
//  Player.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/23/24.
//

import Foundation

class Player {
    @Published fileprivate(set) var numOfGoldenEggs: Int
    @Published private(set) var score: Int = 0
    
    let id: UUID
    
    private var game: EggBreakdownGame?
    private var Game: EggBreakdownGame {
        get throws {
            if game == nil {
                throw CustomError.missingInitializationError
            }
            return game!
        }
    }
    private var gameBreakEgg: ((Int) -> Void)?
    private var GameBreakEgg: (Int) -> Void {
        get throws {
            if gameBreakEgg == nil {
                throw CustomError.missingInitializationError
            }
            return gameBreakEgg!
        }
    }
    private var endAttackTurn: ((Player) -> Void)?
    fileprivate var EndAttackTurn: (Player) -> Void {
        get throws {
            if endAttackTurn == nil {
                throw CustomError.missingInitializationError
            }
            return endAttackTurn!
        }
    }
    
    init(id: UUID, numOfGoldenEggs: Int) {
        self.id = id
        self.numOfGoldenEggs = numOfGoldenEggs
    }
    
    func setGame(gameToPlayer: GameToPlayer) {
        self.game = gameToPlayer.game
        self.gameBreakEgg = gameToPlayer.gameBreakEgg
        self.endAttackTurn = gameToPlayer.endAttackTurn
    }
    
    func startSetupDefenseTurn() -> Void {
        print("\(id) starts setting up defense.")
    }
    
    func pressSetButton() -> Void {
        do {
            try Game.goToAttackPhase()
            print("\(id) pressed Set button.")
            try Game.coverAlphaValues = [0.5, 0.5, 0.5, 0.5, 1, 1, 1, 1]
        } catch {
            print("Game not initialized for player. Press Set button failed.")
        }
    }
    
    func startAttackTurn() -> Void {
        print("\(id)'s attack turn started.")
    }
    
    func breakEgg(at zoneIndex: Int) -> Void {
        do {
            try GameBreakEgg(zoneIndex)
            print("\(id) hits egg at index \(zoneIndex).")
            try EndAttackTurn(self)
        } catch {
            print("GameBreakEgg or EndAttackTurn function not initialized for player. Cannot break egg or end turn.")
        }
    }
    
    func setEgg(at zoneIndex: Int, droppedEggType: EggType) -> Void {
        do {
            if droppedEggType == EggType.golden {
                if try Game.dropZoneEggType[zoneIndex] != droppedEggType {
                    numOfGoldenEggs -= 1
                }
            } else {
                if try Game.dropZoneEggType[zoneIndex] != droppedEggType {
                    numOfGoldenEggs += 1
                }
            }
            try Game.dropZoneEggType[zoneIndex] = droppedEggType
        } catch {
            print("Game not initialized for player. Press Set button failed.")
        }
    }
    
    func incrementScore() -> Void {
        score += 1
    }
}

class RobotPlayer: Player {
    override func pressSetButton() {
        
    }
    
    override func startSetupDefenseTurn() -> Void {
        super.startSetupDefenseTurn()
        let numOfGoldenEggsToBeUsed = Int.random(in: 0...[3, super.numOfGoldenEggs].min()!)
        let arr = [4, 5, 6, 7].shuffled()
        let randomIndexs = Array(arr.prefix(numOfGoldenEggsToBeUsed))
        DispatchQueue.global(qos: .default).async {
            for randomIndex in randomIndexs {
                DispatchQueue.main.async {
                    super.setEgg(at: randomIndex, droppedEggType: EggType.golden)
                }
                sleep(UInt32(0.2))
            }
        }
        print("Robot sets eggs at \(randomIndexs)")
    }
    
    override func startAttackTurn() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            super.startAttackTurn()
            super.breakEgg(at: Int.random(in: 0...3))
            do {
                try super.EndAttackTurn(self)
            } catch {
                print("EndAttackTurn function not initialized for player. Cannot end turn.")
            }
        }
    }
}
