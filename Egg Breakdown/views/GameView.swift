//
//  GameView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject private var game: EggBreakdownGame
    @State private var hammerOffset = CGSize.zero
    @State private var startLocation = CGSize.zero
    @State private var hammerFrame = CGRect.zero
    @State private var rivalEggCupFrames: [CGRect] = []
    @State private var hammerTargetIndex: Int = 0

    private var eggCupDropZones: [EggCupDropZone]
    private var draggableEggCups: [DraggableEggCup]
    private var hammer: Hammer
    private let updateInterval: Double = 0.3
    
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
        
        hammer = Hammer(playerId: p1.id)
    }
    
    var body: some View {
        return VStack {
            HStack {
                Text("Round \(String(game.round))")
                Spacer()
                Text("Time Remaining: 30s")
                Spacer()
                Text("Your Score: \(game.getLocalPlayer().score)")
                Spacer()
                Text("Opponent Score: \(game.getOtherPlayer().score)")
            }
            .frame(height: 50)
            .background(.green)
            .padding()
            
            HStack {
                Image("golden_egg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(String(game.getOtherPlayer().numOfGoldenEggs))
                Rectangle()
                    .foregroundStyle(.background)
            }
            VStack {
                Spacer()
                HStack {
                    ForEach(eggCupDropZones.suffix(eggCupDropZones.count / 2), id: \.id) { dropZone in
                        dropZone
                            .background(GeometryReader { geo in
                                Color.clear
                                    .onAppear {
                                        self.rivalEggCupFrames.append(geo.frame(in: .global))
                                    }
                            })
                    }
                    
//                    ForEach(eggCupDropZones.suffix(eggCupDropZones.count / 2), id: \.id) { dropZone in
//                        dropZone
//                            .dropDestination(for: Hammer.self) { hammers, location in
//                            for hammer in hammers {
//                                if hammer.playerId == dropZone.playerId {
//                                    return false
//                                }
//                                if game.gamePhase != GamePhase.attack {
//                                    print("Not in attack phase, attack failed.")
//                                    return false
//                                }
//                                if game.getLocalPlayer().id != game.attackTurnOwnerID {
//                                    print("It's not your turn to attack yet. Please wait for your opponent.")
//                                    return false
//                                }
//                                
//                                game.getLocalPlayer().breakEgg(at: dropZone.index)
//                            }
//                            return true
//                        } isTargeted: { isTargeted in
//                            game.isZoneTargeted[dropZone.index] = isTargeted
//                        }
//                    }
                }
                .frame(height: 150.0)
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundStyle(.background)
                
                HStack {
                    Rectangle()

                    hammer
                        .offset(x: hammerOffset.width + startLocation.width, y: hammerOffset.height + startLocation.height)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    self.hammerOffset = gesture.translation
                                    detectHammerSelection()
                                }
                                .onEnded { gesture in
                                    let tempFrame = calculateTempHammerFrame()
                                    
                                    for i in 0..<rivalEggCupFrames.count {
                                        let rivalEggCupFrame = rivalEggCupFrames[i]
                                        if tempFrame.intersects(rivalEggCupFrame) {
                                            
                                            break
                                        }
                                    }
                                    
                                    game.isZoneTargeted[hammerTargetIndex] = false
                                    withAnimation {
                                        self.startLocation = .zero
                                        self.hammerOffset = .zero
                                    }
                                }
                        )
                        .background(GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    self.hammerFrame = geo.frame(in: .global)
                                }
                                .onChange(of: self.hammerOffset) { oldState, newState in
                                    self.hammerFrame = geo.frame(in: .global)
                                }
                        })

                }
                .zIndex(1)
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundStyle(.background)
                
                HStack {
                    ForEach(eggCupDropZones.prefix(eggCupDropZones.count / 2), id: \.id) { dropZone in
                        dropZone
                            .dropDestination(for: DraggableEggCup.self) { droppedEggCups, location in
                                for droppedEggCup in droppedEggCups {
                                    if game.getLocalPlayer().numOfGoldenEggs < 1 {
                                        print("\(game.getLocalPlayer().id) has not enough golden eggs.")
                                        return false
                                    }
                                    if droppedEggCup.playerId != dropZone.playerId {
                                        return false
                                    }
                                    if game.gamePhase != GamePhase.setupDefense {
                                        print("Not in setup defense phase, cannot set.")
                                        return false
                                    }
                                    
                                    // drag an egg to zone
                                    game.getLocalPlayer().setEgg(at: dropZone.index, droppedEggType: droppedEggCup.eggType)
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
            .zIndex(1)
            HStack {
                draggableEggCups[0]
                    .draggable(draggableEggCups[0])
                
                Rectangle()
                    .foregroundStyle(.background)
                Button {
                    game.getLocalPlayer().pressSetButton()
                } label: {
                    Text("Set")
                }
                .opacity(game.gamePhase == GamePhase.setupDefense ? 1 : 0)
                
                Rectangle()
                    .foregroundStyle(.background)
                
                Text(String(game.getLocalPlayer().numOfGoldenEggs))
                draggableEggCups[1]
                    .draggable(draggableEggCups[1])
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func detectHammerSelection() -> Void {
        let tempFrame = calculateTempHammerFrame()
            
        for i in 0..<rivalEggCupFrames.count {
            let rivalEggCupFrame = rivalEggCupFrames[i]
            if game.isZoneTargeted[hammerTargetIndex] {
                game.isZoneTargeted[hammerTargetIndex] = false
            }
            if tempFrame.intersects(rivalEggCupFrame) {
                hammerTargetIndex = i+game.isZoneTargeted.count/2
                game.isZoneTargeted[hammerTargetIndex] = true
                break
            }
            else {
                
            }
        }
    }
    
    func calculateTempHammerFrame() -> CGRect {
        return CGRect(x: -hammerFrame.minX - hammerOffset.width,
                      y: -hammerFrame.minY - hammerOffset.height,
                      width: hammerFrame.width,
                      height: hammerFrame.height)
    }
}
