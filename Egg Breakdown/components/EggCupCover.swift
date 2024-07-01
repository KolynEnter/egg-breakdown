//
//  Cover.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/23/24.
//

import SwiftUI

struct EggCupCover: View {
    @ObservedObject private var game: EggBreakdownGame
    
    private let index: Int
    
    init(game: EggBreakdownGame, index: Int) {
        self.game = game
        
        self.index = index
    }
    
    var body: some View {
        return ZStack {
            Image("bag")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(game.coverAlphaValues[index])
        }
    }
}
