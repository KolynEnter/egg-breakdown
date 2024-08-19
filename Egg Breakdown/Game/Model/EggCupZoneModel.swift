//
//  EggCupZoneModel.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/30/24.
//

import Foundation

class EggCupZoneModel {
    private var frame: CGRect? = nil
    var Frame: CGRect {
        get throws {
            if frame == nil {
                throw CustomError.missingInitializationError
            }
            return frame!
        }
    }
    let index: Int
    let playerId: UUID
    
    init(index: Int, playerId: UUID) {
        self.index = index
        self.playerId = playerId
    }
    
    func setFrame(newFrame: CGRect) -> Void {
        frame = newFrame
    }
}
