//
//  MainView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var game: EggBreakdownGame
    @State private var navigate = false

    let p1: Player
    let p2: Player
    
    init() {
        p1 = Player(id: UUID(), numOfGoldenEggs: 8, name: "Player")
        p2 = RobotPlayer(id: UUID(), numOfGoldenEggs: 8, name: "Robot")
        game = EggBreakdownGame(player1: p1, player2: p2)
        
        SoundManager.shared.playBGM(bgmName: "bgm_loop", extension: "mp3")
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text(/*@START_MENU_TOKEN@*/"Egg Breakdown!"/*@END_MENU_TOKEN@*/)
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    performActionBeforeNavigation()
                }) {
                    Text("Start Game")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .navigationDestination(isPresented: $navigate) {
                GameView(game: game, popupControl: game.popupControl, p1: p1, p2: p2)
            }
        }
    }
    
    func performActionBeforeNavigation() {
        navigate = true
    }
}
