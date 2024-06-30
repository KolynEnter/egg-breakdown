//
//  HammerComp.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/30/24.
//

import SwiftUI


struct HammerComponent: View {
    @ObservedObject private var game: EggBreakdownGame
    @ObservedObject private var controller: HammerController
    
    private let targetZoneArea: EggCupZonesComponent
    
    init(playerId: UUID, game: EggBreakdownGame, targetZoneArea: EggCupZonesComponent) {
        self.game = game
        controller = HammerController(game: game, playerId: playerId, targetZoneArea: targetZoneArea)
        self.targetZoneArea = targetZoneArea
    }
    
    var body: some View {
        controller.getView()
            .offset(x: controller.getOffset().width,
                    y: controller.getOffset().height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        controller.setOffset(newOffset: gesture.translation)
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
                            controller.setOffset(newOffset: .zero)
                        }
                    }
            )
            .background(GeometryReader { geo in
                Color.clear
                    .onAppear {
                        controller.setFrame(newFrame: geo.frame(in: .global))
                    }
                    .onChange(of: controller.getOffset()) { oldState, newState in
                        controller.setFrame(newFrame: geo.frame(in: .global))
                    }
            })
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
