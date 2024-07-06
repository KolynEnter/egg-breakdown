//
//  GameView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject private var game: EggBreakdownGame

    private var hammerView: HammerView
    private var eggCupZoneListView1: EggCupZoneListView
    private var eggCupZoneListView2: EggCupZoneListView
    private var dragEgg1: DragEggCupView
    private var dragEgg2: DragEggCupView
    private var popupView: GamePopupView

    init(game: EggBreakdownGame, popupControl: PopupHelper, p1: Player, p2: Player) {
        self.game = game
        
        popupView = GamePopupView(popupControl: popupControl)
        eggCupZoneListView1 = EggCupZoneListView(game: game, startIndex: 0, playerId: p1.id)
        eggCupZoneListView2 = EggCupZoneListView(game: game, startIndex: 4, playerId: p2.id)
        hammerView = HammerView(game: game, targets: eggCupZoneListView2)
        dragEgg1 = DragEggCupView(game: game, targets: eggCupZoneListView1, eggType: EggType.golden)
        dragEgg2 = DragEggCupView(game: game, targets: eggCupZoneListView1, eggType: EggType.normal)
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
                        
                        hammerView
                            .zIndex(1)
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
                        
                        dragEgg2
                            .zIndex(1)
                        
                        Rectangle()
                            .opacity(0)
                        
                        Button {
                            game.getLocalPlayer().pressSetButton()
                        } label: {
                            Text("Set")
                        }
                        .opacity(game.gamePhase == GamePhase.setupDefense ? 1 : 0)
                        
                        Rectangle()
                            .opacity(0)
                        
                        Text(String(game.getLocalPlayer().numOfGoldenEggs))
                        
                        dragEgg1
                            .zIndex(1)
                        
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
