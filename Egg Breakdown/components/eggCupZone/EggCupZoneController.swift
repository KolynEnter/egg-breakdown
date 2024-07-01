//
//  EggCupZoneController.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/30/24.
//

import Foundation

struct EggCupZoneController {
    private let model: EggCupZoneModel
    private let view: EggCupZoneView
    
    init(game: EggBreakdownGame, index: Int, playerId: UUID) {
        model = EggCupZoneModel(index: index, playerId: playerId)
        view = EggCupZoneView(game: game, index: index)
    }
    
    func getView() -> EggCupZoneView {
        return view
    }
    
    func getIndex() -> Int {
        return model.index
    }
    
    func getPlayerId() -> UUID {
        return model.playerId
    }
    
    func getFrame() throws -> CGRect {
        return try model.Frame
    }
    
    func setFrame(newFrame: CGRect) -> Void {
        model.setFrame(newFrame: newFrame)
    }
}
