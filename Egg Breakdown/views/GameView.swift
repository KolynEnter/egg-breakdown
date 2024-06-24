//
//  GameView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject private var game: EggBreakdownGame
    
    var eggCupDropZones: [EggCupDropZone]
    var draggableEggCups: [DraggableEggCup]
    var hammer1: Hammer
    
    init(game: EggBreakdownGame, p1: Player, p2: Player) {
        self.game = game
        
        eggCupDropZones = []
        eggCupDropZones.append(EggCupDropZone(playerId: p1.id, isTargeted: game.isZoneTargeted[0], game: game, index: 0))
        eggCupDropZones.append(EggCupDropZone(playerId: p1.id, isTargeted: game.isZoneTargeted[1], game: game, index: 1))
        eggCupDropZones.append(EggCupDropZone(playerId: p1.id, isTargeted: game.isZoneTargeted[2], game: game, index: 2))
        eggCupDropZones.append(EggCupDropZone(playerId: p1.id, isTargeted: game.isZoneTargeted[3], game: game, index: 3))
        eggCupDropZones.append(EggCupDropZone(playerId: p2.id, isTargeted: game.isZoneTargeted[4], game: game, index: 4))
        eggCupDropZones.append(EggCupDropZone(playerId: p2.id, isTargeted: game.isZoneTargeted[5], game: game, index: 5))
        eggCupDropZones.append(EggCupDropZone(playerId: p2.id, isTargeted: game.isZoneTargeted[6], game: game, index: 6))
        eggCupDropZones.append(EggCupDropZone(playerId: p2.id, isTargeted: game.isZoneTargeted[7], game: game, index: 7))
        
        draggableEggCups = []
        draggableEggCups.append(DraggableEggCup(playerId: p1.id, eggType: EggType.normal))
        draggableEggCups.append(DraggableEggCup(playerId: p1.id, eggType: EggType.golden))
        draggableEggCups.append(DraggableEggCup(playerId: p2.id, eggType: EggType.normal))
        draggableEggCups.append(DraggableEggCup(playerId: p2.id, eggType: EggType.golden))
        
        hammer1 = Hammer(playerId: p1.id)
    }
    
    var body: some View {
        return VStack {
            HStack {
                Text("Round \(String(game.round)) [Setup defense]")
                Spacer()
                Text("Time remaining: 30s")
            }
            .frame(height: 50)
            .background(.green)
            .padding()
            
            HStack {
                Image("golden_egg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(String(game.rivalGoldenEggs))
                Rectangle()
                    .foregroundColor(.white)
            }
            VStack {
                Spacer()
                HStack {
                    ForEach(eggCupDropZones.suffix(eggCupDropZones.count / 2), id: \.id) { dropZone in
                        dropZone
                            .dropDestination(for: Hammer.self) { hammers, location in
                            for hammer in hammers {
                                if hammer.playerId == dropZone.playerId {
                                    return false
                                }
                                game.breakEgg(at: dropZone.index)
                            }
                            return true
                        } isTargeted: { isTargeted in
                            game.isZoneTargeted[dropZone.index] = isTargeted
                        }
                    }
                }
                .frame(height: 150.0)
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(.white)
                
                HStack {
                    Rectangle()

                    hammer1
                        .draggable(hammer1)
                }
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(.white)
                
                HStack {
                    ForEach(eggCupDropZones.prefix(eggCupDropZones.count / 2), id: \.id) { dropZone in
                        dropZone
                            .dropDestination(for: DraggableEggCup.self) { droppedEggCups, location in
                                for droppedEggCup in droppedEggCups {
                                    if droppedEggCup.playerId != dropZone.playerId {
                                        return false
                                    }
                                    let droppedEggType = droppedEggCup.eggType
                                    if droppedEggType == EggType.golden {
                                        if game.dropZoneEggType[dropZone.index] != droppedEggType {
                                            game.localGoldenEggs -= 1
                                        }
                                    } else {
                                        if game.dropZoneEggType[dropZone.index] != droppedEggType {
                                            game.localGoldenEggs += 1
                                        }
                                    }
                                    game.dropZoneEggType[dropZone.index] = droppedEggType
                                }
                                return true
                            } isTargeted: { isTargeted in
                                game.isZoneTargeted[dropZone.index] = isTargeted
                            }
                    }
                }
                .frame(height: 150.0)
                Spacer()
            }
            HStack {
                draggableEggCups[0]
                    .draggable(draggableEggCups[0])
                
                Rectangle()
                    .foregroundColor(.white)
                Button {
                    print("set")
                } label: {
                    Text("Set")
                }
                Rectangle()
                    .foregroundColor(.white)
                
                Text(String(game.localGoldenEggs))
                draggableEggCups[1]
                    .draggable(draggableEggCups[1])
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
