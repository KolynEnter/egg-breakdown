//
//  MainView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import SwiftUI

struct MainView: View {
    @State private var isInGame: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text(/*@START_MENU_TOKEN@*/"Egg Breakdown!"/*@END_MENU_TOKEN@*/)
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink(destination: GameView()) {
                    Text("Start Game")
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    MainView()
}
