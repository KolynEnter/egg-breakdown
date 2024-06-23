//
//  Egg_Cup.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import SwiftUI

struct EggCup: View {
    let id: UUID
    let eggType: EggType
    let isCovered: Bool
    
    var body: some View {
        return ZStack {
            getEggImage(eggType: eggType)
            
            if isCovered {
                Image("bag")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

func getEggImage(eggType: EggType) -> some View {
    if eggType == EggType.normal {
        return Image("egg")
                .resizable()
                .aspectRatio(contentMode: .fit)
    } else if eggType == EggType.golden {
        return Image("golden")
                .resizable()
                .aspectRatio(contentMode: .fit)
    } else {
        return Image("broken")
                .resizable()
                .aspectRatio(contentMode: .fit)
    }
}

enum EggType: Codable {
    case normal, golden, broken
}
