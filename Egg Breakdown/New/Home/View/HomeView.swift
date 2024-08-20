//
//  HomeView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/19/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(MenuViewModel.self) var menuViewModel: MenuViewModel
    @Environment(OptionsViewModel.self) var optionsViewModel: OptionsViewModel

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
                        // Navigate to game view
                        NavigationLink(destination: NewGameView()) {
                            Text("Single player")
                                .padding()
                                .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                                .foregroundColor(Color.TextColorPrimary)
                                .background(.clear)
                        }
                        .allowsHitTesting(menuViewModel.currentMenu == .none)
                        Rectangle()
                            .frame(height: 50)
                            .opacity(0)
                        Button(action: {
                            menuViewModel.currentMenu = .settings
                        }) {
                            Text("Settings")
                                .padding()
                                .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                                .foregroundColor(Color.TextColorPrimary)
                                .background(.clear)
                        }
                        Button(action: {
                            menuViewModel.currentMenu = .rules
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
                        if menuViewModel.currentMenu == .settings {
                            NewSettingsView()
                        }
                        if menuViewModel.currentMenu == .rules {
                            RulesView()
                        }
                    }
                }
            }
            .background(Color.BackgroundColor)
        }
    }
}

#Preview {
    HomeView()
        .environment(MenuViewModel())
        .environment(OptionsViewModel())
}
