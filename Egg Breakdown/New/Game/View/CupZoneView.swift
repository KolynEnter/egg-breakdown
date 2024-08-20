//
//  NewEggCupZoneView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/20/24.
//

import SwiftUI

struct CupZoneView: View {
    var gameViewModel: GameViewModel
    let index: Int
    let playerIndex: Int
    private var getModel: CupZoneListModel {
        get {
            return gameViewModel.cupZoneLists[playerIndex].model
        }
    }
    private let eggViews: [EggType: some View] = [
        EggType.normal: getEggCupImage(eggType: EggType.normal),
        EggType.golden: getEggCupImage(eggType: EggType.golden),
        EggType.broken: getEggCupImage(eggType: EggType.broken)
    ]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(maxWidth: .infinity)
                .foregroundColor(getModel.isZoneTargeted[index] ? .teal.opacity(0.15) : Color(.secondarySystemFill))
            
            eggViews[getModel.dropZoneEggType[index]]
            NewCupCoverView(model: getModel, index: index)
        }
    }
}
