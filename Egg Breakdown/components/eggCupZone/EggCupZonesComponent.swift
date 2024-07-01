//
//  Game.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/30/24.
//

import SwiftUI

struct EggCupZonesComponent: View {
    private let controllers: [EggCupZoneController]
    private let zoneViews: [ZoneViewWithID]
    
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
            ZoneViewWithID(view: controllers[0].getView(), id: UUID(), localIndex: 0),
            ZoneViewWithID(view: controllers[1].getView(), id: UUID(), localIndex: 1),
            ZoneViewWithID(view: controllers[2].getView(), id: UUID(), localIndex: 2),
            ZoneViewWithID(view: controllers[3].getView(), id: UUID(), localIndex: 3),
        ]
    }
    
    var body: some View {
        return (
            HStack {
                ForEach(zoneViews, id: \.id) { zoneView in
                    zoneView
                        .background(GeometryReader { geo in Color.clear
                        .onAppear {
                            controllers[zoneView.localIndex].setFrame(newFrame: geo.frame(in: .global))
                        }
                    })
                }
            }
        )
    }
    
    func getControllers() -> [EggCupZoneController] {
        return controllers
    }
}

struct ZoneViewWithID: View {
    let view: EggCupZoneView
    let id: UUID
    let localIndex: Int
    
    var body: some View {
        view
    }
}
