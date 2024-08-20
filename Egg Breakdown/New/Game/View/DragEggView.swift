//
//  DragEggView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/20/24.
//

import SwiftUI

struct DragEggView: View {
    @Environment(GameViewModel.self) var gameViewModel: GameViewModel
    @State private var offset = CGSize.zero
    @State private var frame = CGRect.zero
    
    var viewModel: DragEggViewModel
    
    private var getLocalModel: CupZoneListModel {
        get {
            return gameViewModel.cupZoneLists[viewModel.localIndex].model
        }
    }
    
    var body: some View {
        getEggImage(eggType: viewModel.eggType)
            .offset(x: offset.width, y: offset.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in


                        offset = gesture.translation

                        let currFrame = getCurrFrame()
                        let cupFrames = getLocalModel.cupFrames
                        for i in 0 ..< cupFrames.count {
                            if getLocalModel.isZoneTargeted[i] {
                                gameViewModel.cupZoneLists[viewModel.localIndex].unTargetEgg(at: i)
                            }
                        }
                        for i in 0 ..< cupFrames.count {
                            if currFrame.intersects(getLocalModel.cupFrames[i]) {
                                viewModel.targetIndex = i
                                gameViewModel.cupZoneLists[viewModel.localIndex].targetEgg(at: i)
                                break
                            }
                        }
                    }
                    .onEnded { gesture in
                        let currFrame = getCurrFrame()
                        
                        let cupFrames = getLocalModel.cupFrames
                        
                        for i in 0 ..< cupFrames.count {

                            let eggCupFrame = cupFrames[i]
                            if currFrame.intersects(eggCupFrame) {
//                                if game.gamePhase != GamePhase.attack {
////                                    print("Not in attack phase, attack failed.")
//                                    game.popup(message: "Not in attack phase, attack failed.")
//                                    break
//                                }
//                                if game.getLocalPlayer().id != game.turnOwner?.id {
////                                    print("It's not your turn to attack yet. Please wait for your opponent.")
//                                    game.popup(message: "It's not your turn to attack yet. Please wait for your opponent.")
//                                    break
//                                }
//                                game.getLocalPlayer().breakEgg(at: targetIndex)
                                
                                break
                            }
                        }
                        
                        gameViewModel.cupZoneLists[viewModel.localIndex].unTargetEgg(at: viewModel.targetIndex)
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
    
    private func getCurrFrame() -> CGRect {
        return CGRect(x: offset.width + frame.minX,
                      y: offset.height + frame.minY,
                      width: frame.width,
                      height: frame.height)
    }
}
