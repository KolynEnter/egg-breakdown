//
//  HammerViewModel.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/30/24.
//

import SwiftUI

struct HammerView: View {
    @ObservedObject private var game: EggBreakdownGame
    @State private var offset = CGSize.zero
    @State private var frame = CGRect.zero
    @State private var targetIndex: Int = 0
    
    private let targets: EggCupZoneListView
    
    init(game: EggBreakdownGame, targets: EggCupZoneListView) {
        self.game = game

        self.targets = targets
    }
    
    var body: some View {
        Image("hammer")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 128.0, height: 128.0)
            .offset(x: offset.width, y: offset.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if game.hasGameEnd {
                            return
                        }
                        offset = gesture.translation
                        showHammerSelection()
                    }
                    .onEnded { gesture in
                        let currFrame = getCurrFrame()
                        let eggCupFrames = game.eggCupFrames
                        
                        for i in 0 ..< eggCupFrames.count {
                            if !isZoneIndexMatch(globalIndex: i) {
                                continue
                            }
                            
                            let eggCupFrame = eggCupFrames[i]
                            if currFrame.intersects(eggCupFrame) {
                                if game.gamePhase != GamePhase.attack {
//                                    print("Not in attack phase, attack failed.")
                                    game.popup(message: "Not in attack phase, attack failed.")
                                    break
                                }
                                if game.getLocalPlayer().id != game.turnOwner?.id {
//                                    print("It's not your turn to attack yet. Please wait for your opponent.")
                                    game.popup(message: "It's not your turn to attack yet. Please wait for your opponent.")
                                    break
                                }
                                game.getLocalPlayer().breakEgg(at: targetIndex)
                                
                                break
                            }
                        }
                        
                        game.isZoneTargeted[targetIndex] = false
                        withAnimation {
                            offset = .zero
                        }
                    }
            )
            .background(GeometryReader { geo in Color.clear
                    .onAppear {
                        frame = geo.frame(in: .global)
                    }
                    .onChange(of: offset) { oldState, newState in
                        frame = geo.frame(in: .global)
                    }
            })
    }
    
    private func isZoneIndexMatch(globalIndex: Int) -> Bool {
        return targets.getControllers().contains { controller in
            controller.getIndex() == globalIndex
        }
    }
    
    private func showHammerSelection() -> Void {
        let currFrame = getCurrFrame()
        let eggCupFrames = game.eggCupFrames
        
        for i in 0 ..< eggCupFrames.count {
            if !isZoneIndexMatch(globalIndex: i) {
                continue
            }
            if game.isZoneTargeted[i] {
                game.isZoneTargeted[i] = false
            }
        }

        for i in 0 ..< eggCupFrames.count {
            if !isZoneIndexMatch(globalIndex: i) {
                continue
            }
            if currFrame.intersects(eggCupFrames[i]) {
                targetIndex = i
                game.isZoneTargeted[i] = true
                break
            }
        }
    }
    
    private func getCurrFrame() -> CGRect {
        return CGRect(x: offset.width + frame.minX,
                      y: offset.height + frame.minY,
                      width: frame.width,
                      height: frame.height)
    }
}
