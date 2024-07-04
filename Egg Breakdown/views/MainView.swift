//
//  MainView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var game: EggBreakdownGame
    let p1: Player
    let p2: Player
    
    init() {
        p1 = Player(id: UUID(), numOfGoldenEggs: 8, name: "Player")
        p2 = RobotPlayer(id: UUID(), numOfGoldenEggs: 8, name: "Robot")
        game = EggBreakdownGame(player1: p1, player2: p2)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text(/*@START_MENU_TOKEN@*/"Egg Breakdown!"/*@END_MENU_TOKEN@*/)
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink(destination: GameView(game: game, p1: p1, p2: p2)) {
                    Text("Start Game")
                }
                
                Spacer()
            }
        }
    }
}
