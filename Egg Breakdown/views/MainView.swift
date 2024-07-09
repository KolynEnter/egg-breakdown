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
    @State private var isDarkModeOn = false
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    let p1: Player
    let p2: Player
    
    init() {
        p1 = Player(id: UUID(), numOfGoldenEggs: 8, name: "Player")
        p2 = RobotPlayer(id: UUID(), numOfGoldenEggs: 8, name: "Robot")
        game = EggBreakdownGame(player1: p1, player2: p2)
        
        SoundManager.shared.playBGM(bgmName: "bgm_loop", extension: "mp3")
    }
    
    var ToggleThemeView: some View {
        Toggle("Dark Mode", isOn: $isDarkModeOn).onChange(of: isDarkModeOn) { (oldState, newState)  in
            changeDarkMode(state: newState)
        }.labelsHidden()
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
                                .font(Font.custom("This-Cafe", size: 32))
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
                                .font(Font.custom("This-Cafe", size: 32))
                                .foregroundColor(Color.TextColorPrimary)
                                .background(.clear)
                        }
                        
                        Button(action: {
                            isShowTutorial = true
                        }) {
                            Text("Tutorial")
                                .padding()
                                .font(Font.custom("This-Cafe", size: 32))
                                .foregroundColor(Color.TextColorPrimary)
                                .background(.clear)
                        }
                        
                        ToggleThemeView
                        
                        Spacer()
                    }
                    
                    VStack {
                        TutorialView(isShow: $isShowTutorial,
                                     height: 350,
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
            .onAppear(perform: {
                setAppTheme()
            })
            .background(Color.BackgroundColor)
        }
    }
    
    func setAppTheme(){
      //MARK: use saved device theme from toggle
      isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
      changeDarkMode(state: isDarkModeOn)
      //MARK: or use device theme
      /*if (colorScheme == .dark)
      {
        isDarkModeOn = true
      }
      else{
        isDarkModeOn = false
      }
      changeDarkMode(state: isDarkModeOn)*/
    }
    
    func changeDarkMode(state: Bool){
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
    
    func performActionBeforeNavigation() {
        navigate = true
    }
}
