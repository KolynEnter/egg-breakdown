//
//  CupZoneListModel.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/20/24.
//

import Foundation

struct CupZoneListModel {
    var isZoneTargeted: [Bool] = Array(repeating: false, count: 4)
    var coverAlphaValue: [Float] = Array(repeating: 0, count: 4)
    var dropZoneEggType: [EggType] = Array(repeating: EggType.normal, count: 4)
    var cupFrames: [CGRect] = Array(repeating: .zero, count: 4)
}
