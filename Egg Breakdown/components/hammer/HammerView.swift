//
//  HammerView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/29/24.
//

import SwiftUI

struct HammerView: View {
    var body: some View {
        return ZStack {
            Image("hammer")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 128.0, height: 128.0)
                .fixedSize(horizontal: true, vertical: true)
        }
    }
}
