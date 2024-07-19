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
    @State private var isShowTutorial: Bool = false
    @State private var isShowSettings: Bool = false
    
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
                Rectangle()
                    .frame(height: 50)
                    .opacity(0)
                
                Image("main_title")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                ZStack {
                    VStack {
                        
                        Spacer()
                        
                        Button(action: {
                            performActionBeforeNavigation()
                        }) {
                            Text("Single player")
                                .padding()
                                .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                                .foregroundColor(Color.TextColorPrimary)
                                .background(.clear)
                        }
                        
                        Rectangle()
                            .frame(height: 50)
                            .opacity(0)
                        
                        Button(action: {
                            isShowSettings = true
                        }) {
                            Text("Settings")
                                .padding()
                                .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                                .foregroundColor(Color.TextColorPrimary)
                                .background(.clear)
                        }
                        
                        Button(action: {
                            isShowTutorial = true
                        }) {
                            Text("Rules")
                                .padding()
                                .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                                .foregroundColor(Color.TextColorPrimary)
                                .background(.clear)
                        }
                        
                        Spacer()
                    }
                    
                    VStack {
                        TutorialView(isShow: $isShowTutorial,
                                     height: 300,
                                     width: 300)
                    }
                    VStack {
                        SettingsView(isShow: $isShowSettings,
                                     height: 350,
                                     width: 300)
                    }
                }
            }
            .navigationDestination(isPresented: $navigate) {
                GameView(game: game, popupControl: game.popupControl, p1: p1, p2: p2)
            }
            .background(Color.BackgroundColor)
        }
    }
    
    private func performActionBeforeNavigation() {
        navigate = true
    }
}
