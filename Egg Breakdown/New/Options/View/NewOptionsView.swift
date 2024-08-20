//
//  NewOptionsView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/19/24.
//

import SwiftUI

struct NewOptionsView: View {
    @Environment(MenuViewModel.self) var menuViewModel: MenuViewModel
    @Environment(OptionsViewModel.self) var optionsViewModel: OptionsViewModel
    
    var confirmExitView: some View {
        NavigationStack {
            VStack {
                Text("Are you sure you want to leave?")
                    .padding()
                    .font(Font.custom("Coffee-Fills", size: TextSize.large.rawValue))
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)
                
                HStack {
                    Spacer()
                    NavigationLink(destination: HomeView()) {
                        Text("Yes")
                            .padding()
                            .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                            .foregroundColor(Color.TextColorPrimary)
                            .background(.clear)
                    }
                    
                    Spacer()
                    Button {
                        menuViewModel.showMenu(.none)
                    } label: {
                        Text("No")
                            .padding()
                            .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                            .foregroundColor(Color.TextColorPrimary)
                            .background(.clear)
                    }
                    Spacer()
                }
            }
            .frame(width: 300, height: 300)
            .background(Color.BackgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
            .opacity(menuViewModel.currentMenu == .exitGame ? 1 : 0)
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    menuViewModel.currentMenu = .settings
                } label: {
                    Text("Settings")
                        .padding()
                        .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                        .foregroundColor(Color.TextColorPrimary)
                        .background(.clear)
                }
                Button {
                    menuViewModel.currentMenu = .rules
                } label: {
                    Text("Rules")
                        .padding()
                        .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                        .foregroundColor(Color.TextColorPrimary)
                        .background(.clear)
                }
                Button {
                    menuViewModel.currentMenu = .exitGame
                } label: {
                    Text("Exit Game")
                        .padding()
                        .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                        .foregroundColor(Color.TextColorPrimary)
                        .background(.clear)
                }
                Button {
                    menuViewModel.currentMenu = .none
                } label: {
                    Text("Close")
                        .padding()
                        .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                        .foregroundColor(Color.TextColorPrimary)
                        .background(.clear)
                }
            }
            
            VStack {
                if menuViewModel.currentMenu == .settings {
                    NewSettingsView()
                }
                if menuViewModel.currentMenu == .rules {
                    RulesView()
                }
                if menuViewModel.currentMenu == .exitGame {
                    confirmExitView
                }
            }
        }
        .frame(width: 300, height: 300)
        .background(Color.BackgroundColor)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
        .opacity(menuViewModel.currentMenu == .options ||
                 menuViewModel.currentMenu == .settings ||
                 menuViewModel.currentMenu == .rules ||
                 menuViewModel.currentMenu == .exitGame
                 ? 1 : 0)
    }
}

#Preview {
    NewOptionsView()
        .environment(MenuViewModel(defaultMenu: .options))
        .environment(OptionsViewModel())
}
