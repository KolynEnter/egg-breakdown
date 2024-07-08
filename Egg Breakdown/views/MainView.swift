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
                
                HStack {
                    Image("main_title")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                Spacer()
                
                Button(action: {
                    performActionBeforeNavigation()
                }) {
                    Text("Single player")
                        .padding()
                        .font(Font.custom("This-Cafe", size: 32))
                        .foregroundColor(.primary)
                        .background(.clear)
                }
                
                Rectangle()
                    .frame(height: 50)
                    .opacity(0)
                
                Button(action: {
                    
                }) {
                    Text("Settings")
                        .padding()
                        .font(Font.custom("This-Cafe", size: 32))
                        .foregroundColor(.primary)
                        .background(.clear)
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
