//
//  Cover.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/23/24.
//

import SwiftUI

struct EggCupCover: View {
    let coverAlphaValue: Double
    
    var body: some View {
        return ZStack {
            Image("bag")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(coverAlphaValue)
        }
    }
}
