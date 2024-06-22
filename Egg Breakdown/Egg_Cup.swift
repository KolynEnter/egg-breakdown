//
//  Egg_Cup.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import SwiftUI

struct EggCup: View {
    var body: some View {
        return ZStack {
            Image("egg")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Image("bag")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
