//
//  NewTossCoinView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/20/24.
//

import SwiftUI

struct NewTossCoinView: View {
    @Environment(GameViewModel.self) var gameViewModel: GameViewModel
    @Environment(WindowViewModel.self) var windowViewModel: WindowViewModel
    
    var body: some View {
        VStack {
            Text("It's a \(gameViewModel.isLocalPlayerFirstHand ? "Head" : "Tail")!")
                .padding()
                .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                .foregroundColor(Color.TextColorPrimary)
                .background(.clear)
            
            Text(gameViewModel.isLocalPlayerFirstHand ?
                 "You will always attack first during this game." :
                 "You will attack after your opponent.")
                .padding()
                .font(Font.custom("Coffee-Fills", size: TextSize.medium.rawValue))
                .foregroundColor(Color.TextColorPrimary)
                .background(.clear)
            
            Image(gameViewModel.isLocalPlayerFirstHand ? "head" : "tail")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button {
                windowViewModel.showMenu(.none)
            } label: {
                Text("Close")
                    .padding()
                    .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)
            }
        }
        .frame(width: 300, height: 300)
        .background(Color.BackgroundColor)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}

#Preview {
    NewTossCoinView()
        .environment(GameViewModel())
        .environment(WindowViewModel(defaultWindow: .tossCoin))
}
