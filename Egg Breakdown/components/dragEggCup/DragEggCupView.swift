//
//  DraggableEggView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/29/24.
//

import SwiftUI

struct DragEggCupView: View {
    @ObservedObject private var game: EggBreakdownGame
    @State private var offset = CGSize.zero
    @State private var frame = CGRect.zero
    @State private var targetIndex: Int = 0
    
    private let targets: EggCupZoneListView
    private let eggType: EggType
    
    init(game: EggBreakdownGame, targets: EggCupZoneListView, eggType: EggType) {
        self.game = game

        self.targets = targets
        self.eggType = eggType
    }
    
    var body: some View {
        getEggImage(eggType: eggType)
            .offset(x: offset.width, y: offset.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if game.hasGameEnd {
                            return
                        }
                        if game.pauseManager.isPaused {
                            return
                        }
                        
                        offset = gesture.translation
                        showDropTargetSelection()
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
                                if game.gamePhase != GamePhase.setupDefense {
//                                    print("Not in setup defense phase, cannot set.")
                                    game.popup(message: "Not in setup defense phase, cannot set egg.")
                                    break
                                }
                                
                                // Convert to global index
                                game.getLocalPlayer().setEgg(at: i, droppedEggType: eggType)
                                break
                            }
                        }
                        
                        game.isZoneTargeted[targetIndex] = false
                        withAnimation {
                            offset = .zero
                        }
                    }
            )
            .background(GeometryReader { geo in
                Color.clear
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
    
    private func showDropTargetSelection() -> Void {
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
