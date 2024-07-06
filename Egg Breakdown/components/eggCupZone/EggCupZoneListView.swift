//
//  EggCupZoneListView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/30/24.
//

import SwiftUI

struct EggCupZoneListView: View {
    @Binding private var isShowDraggables: Bool
    
    private let controllers: [EggCupZoneController]
    private let zoneViews: [ZoneViewWithID]
    private let game: EggBreakdownGame

    init(game: EggBreakdownGame, startIndex: Int, playerId: UUID, isShowDraggables: Binding<Bool>) {
        if startIndex != 0 && startIndex != 4 {
            print("WARNING: start index of egg cup zones component is not 0 nor 4.")
        }
        self.game = game
        
        let c0 = EggCupZoneController(game: game, index: startIndex+0, playerId: playerId)
        let c1 = EggCupZoneController(game: game, index: startIndex+1, playerId: playerId)
        let c2 = EggCupZoneController(game: game, index: startIndex+2, playerId: playerId)
        let c3 = EggCupZoneController(game: game, index: startIndex+3, playerId: playerId)
        
        controllers = [c0, c1, c2, c3]
        
        zoneViews = [
            ZoneViewWithID(view: c0.getView(), id: UUID(), globalIndex: c0.getIndex()),
            ZoneViewWithID(view: c1.getView(), id: UUID(), globalIndex: c1.getIndex()),
            ZoneViewWithID(view: c2.getView(), id: UUID(), globalIndex: c2.getIndex()),
            ZoneViewWithID(view: c3.getView(), id: UUID(), globalIndex: c3.getIndex()),
        ]
        
        self._isShowDraggables = isShowDraggables
    }
    
    var body: some View {
        HStack {
            ForEach(zoneViews, id: \.id) { zoneView in
                zoneView
                    .background(GeometryReader { geo in Color.clear
                            .onAppear {
                                isShowDraggables = true
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
