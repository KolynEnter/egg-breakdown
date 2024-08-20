//
//  GameViewModel.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/19/24.
//

import Foundation

@Observable class GameViewModel {
    var isLocalPlayerFirstHand: Bool {
        return true
    }
    var cupZoneLists: [CupZoneListViewModel] = [
        CupZoneListViewModel(),
        CupZoneListViewModel()
    ]
}
