//
//  EggCupZoneListView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/30/24.
//

import SwiftUI

struct EggCupZoneListView: View {
    private let controllers: [EggCupZoneController]
    private let zoneViews: [ZoneViewWithID]
    private let game: EggBreakdownGame

    init(game: EggBreakdownGame, startIndex: Int, playerId: UUID) {
        if startIndex != 0 && startIndex != 4 {
            print("WARNING: start index of egg cup zones component is not 0 nor 4.")
        }
        
        controllers = [
            EggCupZoneController(game: game, index: startIndex+0, playerId: playerId),
            EggCupZoneController(game: game, index: startIndex+1, playerId: playerId),
            EggCupZoneController(game: game, index: startIndex+2, playerId: playerId),
            EggCupZoneController(game: game, index: startIndex+3, playerId: playerId),
        ]
        
        zoneViews = [
            ZoneViewWithID(view: controllers[0].getView(), id: UUID(), globalIndex: controllers[0].getIndex()),
            ZoneViewWithID(view: controllers[1].getView(), id: UUID(), globalIndex: controllers[1].getIndex()),
            ZoneViewWithID(view: controllers[2].getView(), id: UUID(), globalIndex: controllers[2].getIndex()),
            ZoneViewWithID(view: controllers[3].getView(), id: UUID(), globalIndex: controllers[3].getIndex()),
        ]
        
        self.game = game
    }
    
    var body: some View {
        HStack {
            ForEach(zoneViews, id: \.id) { zoneView in
                zoneView
                    .background(GeometryReader { geo in Color.clear
                            .onAppear {
                                game.eggCupFrames[zoneView.globalIndex] = geo.frame(in: .global)
                            }
                    })
            }
        }
        
    }
    
    func getControllers() -> [EggCupZoneController] {
        return controllers
    }
}

struct ZoneViewWithID: View {
    let view: EggCupZoneView
    let id: UUID
    let globalIndex: Int
        
    var body: some View {
        view
    }
}
