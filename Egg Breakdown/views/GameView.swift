//
//  GameView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject private var game: EggBreakdownGame
    private var draggableEggCups: [DraggableEggCup]
    
    private var hammerView: HammerView
    private var eggCupZoneListView1: EggCupZoneListView
    private var eggCupZoneListView2: EggCupZoneListView

    init(game: EggBreakdownGame, p1: Player, p2: Player) {
        self.game = game

        draggableEggCups = []
        draggableEggCups.append(DraggableEggCup(playerId: p1.id, eggType: EggType.normal))
        draggableEggCups.append(DraggableEggCup(playerId: p1.id, eggType: EggType.golden))
        draggableEggCups.append(DraggableEggCup(playerId: p2.id, eggType: EggType.normal))
        draggableEggCups.append(DraggableEggCup(playerId: p2.id, eggType: EggType.golden))
        
        hammerView = HammerView(game: game)
        eggCupZoneListView1 = EggCupZoneListView(game: game, startIndex: 0, playerId: p1.id)
        eggCupZoneListView2 = EggCupZoneListView(game: game, startIndex: 4, playerId: p2.id)
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
                Spacer()
                
                eggCupZoneListView2
                    .frame(height: 150.0)
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundStyle(.background)

                HStack {
                    Spacer()
                    Rectangle()
                    
                    hammerView
                        .zIndex(1)
                }
                .zIndex(1)
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundStyle(.background)
                
                eggCupZoneListView1
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
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
