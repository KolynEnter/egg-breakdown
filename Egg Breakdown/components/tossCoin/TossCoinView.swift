//
//  TossCoinView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/18/24.
//

import SwiftUI

struct TossCoinView: View {
    @Binding var isShow: Bool
    
    let height: CGFloat
    let width: CGFloat
    let isFirst: Bool
    let gameFlowTimer: GameFlowTimer
    
    var body: some View {
        VStack {
            Text("It's a \(isFirst ? "Head" : "Tail")!")
                .padding()
                .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                .foregroundColor(Color.TextColorPrimary)
                .background(.clear)
            
            Text(isFirst ?
                 "You will always attack first during this game." :
                 "You will attack after your opponent.")
                .padding()
                .font(Font.custom("Coffee-Fills", size: TextSize.medium.rawValue))
                .foregroundColor(Color.TextColorPrimary)
                .background(.clear)
            
            Image(isFirst ? "head" : "tail")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button {
                isShow = false
                gameFlowTimer.isActive = true
            } label: {
                Text("Close")
                    .padding()
                    .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)
            }
        }
        .frame(width: width, height: height)
        .background(Color.BackgroundColor)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
        .opacity(isShow ? 1 : 0)
    }
}
