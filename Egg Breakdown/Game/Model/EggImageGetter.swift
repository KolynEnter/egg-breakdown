//
//  EggImageGetter.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/23/24.
//

import SwiftUI

func getEggCupImage(eggType: EggType) -> some View {
    if eggType == EggType.normal {
        return Image("egg")
                .resizable()
                .aspectRatio(contentMode: .fit)
    } else if eggType == EggType.golden {
        return Image("golden_egg")
                .resizable()
                .aspectRatio(contentMode: .fit)
    } else {
        return Image("broken_egg")
                .resizable()
                .aspectRatio(contentMode: .fit)
    }
}

func getEggImage(eggType: EggType) -> some View {
    if eggType == EggType.normal {
        return Image("egg_d")
                .resizable()
                .aspectRatio(contentMode: .fit)
    } else if eggType == EggType.golden {
        return Image("golden_egg_d")
                .resizable()
                .aspectRatio(contentMode: .fit)
    } else {
        return Image("broken_egg_d")
                .resizable()
                .aspectRatio(contentMode: .fit)
    }
}
