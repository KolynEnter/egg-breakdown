//
//  HomeView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/19/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(WindowViewModel.self) var windowViewModel: WindowViewModel
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
                        .allowsHitTesting(windowViewModel.currentWindow == .none)
                        Rectangle()
                            .frame(height: 50)
                            .opacity(0)
                        Button(action: {
                            windowViewModel.showMenu(.settings)
                        }) {
                            Text("Settings")
                                .padding()
                                .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                                .foregroundColor(Color.TextColorPrimary)
                                .background(.clear)
                        }
                        Button(action: {
                            windowViewModel.showMenu(.rules)
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
                        if windowViewModel.currentWindow == .settings {
                            NewSettingsView()
                        }
                        if windowViewModel.currentWindow == .rules {
                            RulesView()
                        }
                    }
                }
            }
            .background(Color.BackgroundColor)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
        .environment(WindowViewModel())
        .environment(OptionsViewModel())
}
