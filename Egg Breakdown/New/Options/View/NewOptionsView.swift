//
//  NewOptionsView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/19/24.
//

import SwiftUI

struct NewOptionsView: View {
    @Environment(WindowViewModel.self) var windowViewModel: WindowViewModel
    @Environment(OptionsViewModel.self) var optionsViewModel: OptionsViewModel
    
    var confirmExitView: some View {
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
                    windowViewModel.showMenu(.none)
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
        .opacity(windowViewModel.currentWindow == .exitGame ? 1 : 0)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    VStack {
                        Button {
                            windowViewModel.showMenu(.settings)
                        } label: {
                            Text("Settings")
                                .padding()
                                .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                                .foregroundColor(Color.TextColorPrimary)
                                .background(.clear)
                        }
                        Button {
                            windowViewModel.showMenu(.rules)
                        } label: {
                            Text("Rules")
                                .padding()
                                .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                                .foregroundColor(Color.TextColorPrimary)
                                .background(.clear)
                        }
                        Button {
                            windowViewModel.showMenu(.exitGame)
                        } label: {
                            Text("Exit Game")
                                .padding()
                                .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                                .foregroundColor(Color.TextColorPrimary)
                                .background(.clear)
                        }
                        Button {
                            windowViewModel.showMenu(.none)
                        } label: {
                            Text("Close")
                                .padding()
                                .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                                .foregroundColor(Color.TextColorPrimary)
                                .background(.clear)
                        }
                    }
                    
                    VStack {
                        if windowViewModel.currentWindow == .settings {
                            NewSettingsView()
                        }
                        if windowViewModel.currentWindow == .rules {
                            RulesView()
                        }
                        if windowViewModel.currentWindow == .exitGame {
                            confirmExitView
                        }
                    }
                }
            }
            .frame(width: 300, height: 300)
            .background(Color.BackgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
            .opacity(windowViewModel.isInOptionsMenu ? 1 : 0)
        }
    }
}

#Preview {
    NewOptionsView()
        .environment(WindowViewModel(defaultWindow: .options))
        .environment(OptionsViewModel())
}
