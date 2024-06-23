//
//  EggCup_DropZone.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/22/24.
//

import SwiftUI

struct EggCupDropZone: View {
    let id: UUID
    let playerId: UUID
    let isTargeted: Bool
    let eggCup: EggCup
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(maxWidth: .infinity)
                .foregroundColor(isTargeted ? .teal.opacity(0.15) : Color(.secondarySystemFill))
            
            eggCup
        }
    }
}
