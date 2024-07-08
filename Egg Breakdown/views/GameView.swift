//
//  GameView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject private var game: EggBreakdownGame
    // Initialization order
    @State private var isShowDraggables: Bool = false

    private let p1: Player
    private let p2: Player
    private var popupView: GamePopupView

    init(game: EggBreakdownGame, popupControl: PopupHelper, p1: Player, p2: Player) {
        self.game = game
        
        self.p1 = p1
        self.p2 = p2
        popupView = GamePopupView(popupControl: popupControl)
    }
    
    private var eggCupZoneListView1: EggCupZoneListView {
        EggCupZoneListView(game: game, startIndex: 0, playerId: p1.id, isShowDraggables: $isShowDraggables)
    }
    private var eggCupZoneListView2: EggCupZoneListView {
        EggCupZoneListView(game: game, startIndex: 4, playerId: p2.id, isShowDraggables: $isShowDraggables)
    }
    private var hammerView: HammerView {
        HammerView(game: game, targets: eggCupZoneListView2)
    }
    private var dragEgg1: DragEggCupView {
        DragEggCupView(game: game, targets: eggCupZoneListView1, eggType: EggType.golden)
    }
    private var dragEgg2: DragEggCupView {
        DragEggCupView(game: game, targets: eggCupZoneListView1, eggType: EggType.normal)
    }
    
    var body: some View {
        ZStack {
            VStack {
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
                            .font(Font.custom("Coffee-Fills", size: 32))
                            .frame(width: 32)
                        Rectangle()
                            .foregroundStyle(.background)
                    }
                    
                    Spacer()
                    
                    eggCupZoneListView2
                        .frame(height: 150.0)
                        .zIndex(-1)
                    
                    Rectangle()
                        .frame(height: 50)
                        .opacity(0)
                    
                    HStack {
                        Rectangle()
                            .opacity(0)
                        
                        if isShowDraggables {
                            hammerView
                                .zIndex(1)
                        }
                    }
                    .zIndex(2)
                    
                    Rectangle()
                        .frame(height: 50)
                        .opacity(0)
                    
                    eggCupZoneListView1
                        .frame(height: 150.0)
                        .zIndex(-1)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        if isShowDraggables {
                            dragEgg2
                                .zIndex(1)
                        }
                        
                        Text(" ")
                            .font(Font.custom("Coffee-Fills", size: 32))
                            .frame(width: 32)
                        
                        Rectangle()
                            .opacity(0)
                        
                        Button {
                            game.getLocalPlayer().pressSetButton()
                        } label: {
                            Text("Set")
                                .font(Font.custom("This-Cafe", size: 32))
                                .foregroundColor(.primary)
                                .background(.clear)
                        }
                        .opacity(game.gamePhase == GamePhase.setupDefense ? 1 : 0)
                        
                        Rectangle()
                            .opacity(0)
                        
                        Text(String(game.getLocalPlayer().numOfGoldenEggs))
                            .font(Font.custom("Coffee-Fills", size: 32))
                            .frame(width: 32)
                        
                        if isShowDraggables {
                            dragEgg1
                                .zIndex(1)
                        }
                        
                        Spacer()
                    }
                }
            }
            VStack {
                popupView
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
