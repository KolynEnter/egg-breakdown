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
    let name: String
    
    private var game: EggBreakdownGame?
    fileprivate var Game: EggBreakdownGame {
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
    private var endAttackTurn: (() -> Void)?
    fileprivate var EndAttackTurn: () -> Void {
        get throws {
            if endAttackTurn == nil {
                throw CustomError.missingInitializationError
            }
            return endAttackTurn!
        }
    }
    
    init(id: UUID, numOfGoldenEggs: Int, name: String) {
        self.id = id
        self.numOfGoldenEggs = numOfGoldenEggs
        self.name = name
    }
    
    func setGame(gameToPlayer: GameToPlayer) {
        self.game = gameToPlayer.game
        self.gameBreakEgg = gameToPlayer.gameBreakEgg
        self.endAttackTurn = gameToPlayer.endAttackTurn
    }
    
    func startSetupDefenseTurn() -> Void {
//        print("\(name) starts setting up defense.")
    }
    
    func pressSetButton() -> Void {
        do {
            try Game.endSetupDefenseTurn(id: id)
//            print("\(name) pressed Set button.")
            try Game.coverAlphaValues = [0.5, 0.5, 0.5, 0.5, 1, 1, 1, 1]
        } catch {
            print("Game not initialized for player. Press Set button failed.")
        }
    }
    
    func startAttackTurn() -> Void {
//        print("\(name)'s attack turn started.")
    }
    
    func breakEgg(at zoneIndex: Int) -> Void {
        do {
            try GameBreakEgg(zoneIndex)
//            print("\(name) hits egg at index \(zoneIndex).")
            try EndAttackTurn()
        } catch {
            print("GameBreakEgg or EndAttackTurn function not initialized for player. Cannot break egg or end turn.")
        }
    }
    
    func setEgg(at zoneIndex: Int, droppedEggType: EggType) -> Void {
        do {
            if droppedEggType == EggType.golden {
                // True if zone is normal egg
                let isDifferentType = try Game.dropZoneEggType[zoneIndex] != droppedEggType
                
                if try Game.getLocalPlayer().numOfGoldenEggs < 1 && isDifferentType{
//                                    print("\(game.getLocalPlayer().id) has not enough golden eggs.")
                    try Game.popup(message: "You have not enough golden eggs.")
                    return
                }
                
                if isDifferentType {
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
    
    func reInit() -> Void {
        numOfGoldenEggs = 8
        score = 0
    }
}

class RobotPlayer: Player {
    private var modifiedNumOfGoldenEggs: Int
    
    override init(id: UUID, numOfGoldenEggs: Int, name: String) {
        modifiedNumOfGoldenEggs = numOfGoldenEggs
        super.init(id: id, numOfGoldenEggs: numOfGoldenEggs, name: name)
    }
    
    override func setEgg(at zoneIndex: Int, droppedEggType: EggType) {
        do {
            if droppedEggType == EggType.golden {
                if try Game.dropZoneEggType[zoneIndex] != droppedEggType {
                    modifiedNumOfGoldenEggs -= 1
                }
            } else {
                if try Game.dropZoneEggType[zoneIndex] != droppedEggType {
                    modifiedNumOfGoldenEggs += 1
                }
            }
            try Game.dropZoneEggType[zoneIndex] = droppedEggType
        } catch {
            print("Game not initialized for player. Press Set button failed.")
        }
    }
    
    override func pressSetButton() {
        
    }
    
    override func startSetupDefenseTurn() -> Void {
        super.startSetupDefenseTurn()
        modifiedNumOfGoldenEggs = numOfGoldenEggs
        let numOfGoldenEggsToBeUsed = Int.random(in: 0...[3, super.numOfGoldenEggs].min()!)
        let arr = [4, 5, 6, 7].shuffled()
        let randomIndexs = Array(arr.prefix(numOfGoldenEggsToBeUsed))
        DispatchQueue.global(qos: .default).async {
            for randomIndex in randomIndexs {
                DispatchQueue.main.async {
                    self.setEgg(at: randomIndex, droppedEggType: EggType.golden)
                }
                sleep(UInt32(0.2))
            }
            do {
                try self.Game.endSetupDefenseTurn(id: self.id)
//                print("ROBOT: exit setup defense")
            } catch {
                print("Game is not initialized for robot player")
            }
        }
//        print("Robot sets eggs at \(randomIndexs)")
    }
    
    override func startAttackTurn() -> Void {
//        print("ROBOT: attack turn started")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            super.startAttackTurn()
            let breakEggIndex = Int.random(in: 0...3)
//            print("Robot breaks \(breakEggIndex)")
            super.breakEgg(at: breakEggIndex)
            do {
                try super.EndAttackTurn()
            } catch {
                print("EndAttackTurn function not initialized for player. Cannot end turn.")
            }
        }
    }
    
    func revealNumOfGoldenEggs() -> Void {
        numOfGoldenEggs = modifiedNumOfGoldenEggs
    }
}
