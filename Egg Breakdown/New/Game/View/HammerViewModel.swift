//
//  HammerViewModel.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/20/24.
//

import Foundation

@Observable class HammerViewModel {
    let opponentIndex: Int
    var targetIndex: Int
    
    init(opponentIndex: Int) {
        self.opponentIndex = opponentIndex
        targetIndex = 0
    }
}
