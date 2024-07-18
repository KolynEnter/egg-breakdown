//
//  OptionsView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/12/24.
//

import SwiftUI

struct OptionsView: View {
    @Binding var isShow: Bool
    @State private var navigate = false
    @State private var isShowTutorial: Bool = false
    @State private var isShowSettings: Bool = false
    @State private var isShowConfirmExit: Bool = false

    let height: CGFloat
    let width: CGFloat
    let gameFlowTimer: GameFlowTimer
    
    var confirmExitView: some View {
        VStack {
            Text("Are you sure you want to leave?")
                .padding()
                .font(Font.custom("Coffee-Fills", size: TextSize.large.rawValue))
                .foregroundColor(Color.TextColorPrimary)
                .background(.clear)
            
            HStack {
                Spacer()
                NavigationStack {
                    Button {
                        navigate = true
                    } label: {
                        Text("Yes")
                            .padding()
                            .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                            .foregroundColor(Color.TextColorPrimary)
                            .background(.clear)
                    }
                    
                    .navigationDestination(isPresented: $navigate) {
                        ContentView()
                    }
                }
                
                Spacer()
                
                Button {
                    isShowConfirmExit = false
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
        .frame(width: width, height: height)
        .background(Color.BackgroundColor)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
        .opacity(isShowConfirmExit ? 1 : 0)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    isShowSettings = true
                } label: {
                    Text("Settings")
                        .padding()
                        .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                        .foregroundColor(Color.TextColorPrimary)
                        .background(.clear)
                }
                
                Button {
                    isShowTutorial = true
                } label: {
                    Text("Rules")
                        .padding()
                        .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                        .foregroundColor(Color.TextColorPrimary)
                        .background(.clear)
                }
                
                Button {
                    isShowConfirmExit = true
                } label: {
                    Text("Exit Game")
                        .padding()
                        .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                        .foregroundColor(Color.TextColorPrimary)
                        .background(.clear)
                }
                
                Button {
                    isShow = false
                    gameFlowTimer.isActive = true
                } label: {
                    Text("Close")
                        .padding()
                        .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                        .foregroundColor(Color.TextColorPrimary)
                        .background(.clear)
                }
            }
            VStack {
                TutorialView(isShow: $isShowTutorial, height: 300, width: 300)
            }
            VStack {
                SettingsView(isShow: $isShowSettings, height: 350, width: 300)
            }
            VStack {
                confirmExitView
            }
        }
        .frame(width: width, height: height)
        .background(Color.BackgroundColor)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
        .opacity(isShow ? 1 : 0)
    }
}
