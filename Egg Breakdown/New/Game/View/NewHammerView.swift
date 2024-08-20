//
//  NewHammerView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/20/24.
//

import SwiftUI

struct NewHammerView: View {
    @Environment(HammerViewModel.self) var viewModel: HammerViewModel
    @Environment(GameViewModel.self) var gameViewModel: GameViewModel
    @State private var offset = CGSize.zero
    @State private var frame = CGRect.zero
    
    private var getOpponentModel: CupZoneListModel {
        get {
            return gameViewModel.cupZoneLists[viewModel.opponentIndex].model
        }
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

                        
                        offset = gesture.translation

                        let currFrame = getCurrFrame()
                        let cupFrames = getOpponentModel.cupFrames
                        for i in 0 ..< cupFrames.count {
                            if getOpponentModel.isZoneTargeted[i] {
                                gameViewModel.cupZoneLists[viewModel.opponentIndex].unTargetEgg(at: i)
                            }
                        }
                        for i in 0 ..< cupFrames.count {
                            if currFrame.intersects(getOpponentModel.cupFrames[i]) {
                                viewModel.targetIndex = i
                                gameViewModel.cupZoneLists[viewModel.opponentIndex].targetEgg(at: i)
                                break
                            }
                        }
                    }
                    .onEnded { gesture in
                        let currFrame = getCurrFrame()
                        
                        let cupFrames = getOpponentModel.cupFrames
                        
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
                        
                        gameViewModel.cupZoneLists[viewModel.opponentIndex].unTargetEgg(at: viewModel.targetIndex)
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

#Preview {
    NewHammerView()
        .environment(HammerViewModel(opponentIndex: 1))
        .environment(GameViewModel())
}
