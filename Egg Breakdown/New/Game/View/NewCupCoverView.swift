//
//  NewCupCoverView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/20/24.
//

import SwiftUI

struct NewCupCoverView: View {
    var model: CupZoneListModel
    let index: Int
    
    var body: some View {
        ZStack {
            Image("bag")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(Double(model.coverAlphaValue[index]))
        }
    }
}
