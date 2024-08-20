//
//  DragEggViewModel.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/20/24.
//

import Foundation

@Observable class DragEggViewModel {
    let localIndex: Int
    let eggType: EggType
    var targetIndex: Int
    
    init(localIndex: Int, eggType: EggType) {
        self.localIndex = localIndex
        self.eggType = eggType
        targetIndex = 0
    }
}
