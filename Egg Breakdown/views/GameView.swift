//
//  GameView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject private var game: EggBreakdownGame
    @State private var eggCupFrames: [CGRect] = Array(repeating: .zero, count: 8)
    @State private var hammerOffset = CGSize.zero
    @ObservedObject private var controller: HammerController
    
    private let targetZoneArea: EggCupZonesComponent
    
    private var draggableEggCups: [DraggableEggCup]
    private var eggCupZonesComponent1: EggCupZonesComponent
    private var eggCupZonesComponent2: EggCupZonesComponent
//    private var hammerComponent1: HammerComponent
    
    init(game: EggBreakdownGame, p1: Player, p2: Player) {
        self.game = game
        draggableEggCups = []
        draggableEggCups.append(DraggableEggCup(playerId: p1.id, eggType: EggType.normal))
        draggableEggCups.append(DraggableEggCup(playerId: p1.id, eggType: EggType.golden))
        draggableEggCups.append(DraggableEggCup(playerId: p2.id, eggType: EggType.normal))
        draggableEggCups.append(DraggableEggCup(playerId: p2.id, eggType: EggType.golden))
        
        eggCupZonesComponent1 = EggCupZonesComponent(game: game, startIndex: 0, playerId: p1.id)
        eggCupZonesComponent2 = EggCupZonesComponent(game: game, startIndex: 4, playerId: p2.id)
//        hammerComponent1 = HammerComponent(playerId: p1.id, game: game, targetZoneArea: eggCupZonesComponent2)
        controller = HammerController(game: game, playerId: p1.id, targetZoneArea: eggCupZonesComponent2)
        self.targetZoneArea = eggCupZonesComponent2
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
            
            VStack {
                HStack {
                    Image("golden_egg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text(String(game.getOtherPlayer().numOfGoldenEggs))
                    Rectangle()
                        .foregroundStyle(.background)
                }
                Spacer()
                eggCupZonesComponent2
                    .frame(height: 150.0)
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundStyle(.background)

                HStack {
                    Spacer()
                    Rectangle()
                        .frame(height: 50)
                        .foregroundStyle(.background)
                    
//                    hammerComponent1
//                        .zIndex(1)
                    controller.getView()
                        .offset(x: hammerOffset.width,
                                y: hammerOffset.height)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    hammerOffset = gesture.translation
//                                    controller.setOffset(newOffset: gesture.translation)
                                    do {
                                        try showHammerSelection()
                                    } catch {
                                        print("@@@")
                                    }
                                }
                                .onEnded { gesture in
                                    let currFrame = controller.getCurrHammerFrame()
                                    do {
                                        for i in 0 ..< targetZoneArea.getControllers().count {
                                            let eggCupFrame = try targetZoneArea.getControllers()[i].getFrame()
                                            if currFrame.intersects(eggCupFrame) {
                                                if game.gamePhase != GamePhase.attack {
                                                    print("Not in attack phase, attack failed.")
                                                    break
                                                }
                                                else if game.getLocalPlayer().id != game.attackTurnOwnerID {
                                                    print("It's not your turn to attack yet. Please wait for your opponent.")
                                                    break
                                                }
                                                game.getLocalPlayer().breakEgg(at: targetZoneArea.getControllers()[i].getIndex())
                                                break
                                            }
                                        }
                                    } catch {
                                        print("ERROR: target zone area does not have frames.")
                                    }
                                    
                                    game.isZoneTargeted[controller.getTargetIndex()] = false
                                    
                                    
                                    withAnimation {
//                                        controller.setOffset(newOffset: .zero)
                                        hammerOffset = .zero
                                    }
                                }
                        )
                        .background(GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    controller.setFrame(newFrame: geo.frame(in: .global))
                                }
                                .onChange(of: hammerOffset) { oldState, newState in
                                    controller.setFrame(newFrame: geo.frame(in: .global))
                                }
                        })
                }
                .zIndex(1)
                
                eggCupZonesComponent1
                    .frame(height: 150.0)
                Spacer()
                /*
                HStack {
                    Rectangle()
                    
                    hammerComponent

                    
                    Rectangle()
                        .frame(height: 50)
                        .foregroundStyle(.background)
                    
                    HStack {
                        ForEach(eggCupDropZones.prefix(eggCupDropZones.count / 2), id: \.id) { dropZone in
                            dropZone
                                .background(GeometryReader { geo in
                                    Color.clear
                                        .onAppear {
                                            self.eggCupFrames[dropZone.index] = geo.frame(in: .global)
                                        }
                                })
                            //                        dropZone
                            //                            .dropDestination(for: DraggableEggCup.self) { droppedEggCups, location in
                            //                                for droppedEggCup in droppedEggCups {
                            //                                    if game.getLocalPlayer().numOfGoldenEggs < 1 {
                            //                                        print("\(game.getLocalPlayer().id) has not enough golden eggs.")
                            //                                        return false
                            //                                    }
                            //                                    if droppedEggCup.playerId != dropZone.playerId {
                            //                                        return false
                            //                                    }
                            //                                    if game.gamePhase != GamePhase.setupDefense {
                            //                                        print("Not in setup defense phase, cannot set.")
                            //                                        return false
                            //                                    }
                            //
                            //                                    // drag an egg to zone
                            //                                    game.getLocalPlayer().setEgg(at: dropZone.index, droppedEggType: droppedEggCup.eggType)
                            //                                }
                            //                                return true
                            //                            } isTargeted: { isTargeted in
                            //                                game.isZoneTargeted[dropZone.index] = isTargeted
                            //                            }
                        }
                    }
                    .frame(height: 150.0)
                    Spacer()
                }
                .zIndex(1)
                */
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
    }
    
    func showHammerSelection() throws -> Void {
        let currFrame = controller.getCurrHammerFrame()

        do {
            for i in 0 ..< 4 {
                let targetGlobalIndex = targetZoneArea.getControllers()[i].getIndex()
                if game.isZoneTargeted[targetGlobalIndex] {
                    game.isZoneTargeted[targetGlobalIndex] = false
                }
            }
            for i in 0 ..< 4 {
                let targetGlobalIndex = targetZoneArea.getControllers()[i].getIndex()
                let aimingZone = try targetZoneArea.getControllers()[i].getFrame()
                if currFrame.intersects(aimingZone) {
                    controller.setTargetIndex(newIndex: i)
                    game.isZoneTargeted[targetGlobalIndex] = true
                    break
                }
            }
        } catch {
            print("Target Area frames not initialized for hammer, cannot show selection")
        }
    }
}
