//
//  NewGameView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/19/24.
//

import SwiftUI

struct NewGameView: View {
    @Environment(GameViewModel.self) var gameViewModel: GameViewModel
    @Environment(WindowViewModel.self) var windowViewModel: WindowViewModel
    @Environment(OptionsViewModel.self) var optionsViewModel: OptionsViewModel
    
    var hammerViewModel = HammerViewModel(opponentIndex: 1)
    var normalDragEggViewModel = DragEggViewModel(localIndex: 0, eggType: .normal)
    var goldenDragEggViewModel = DragEggViewModel(localIndex: 0, eggType: .golden)
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Rectangle()
                        .frame(height: 100)
                        .opacity(0)
                    ZStack {
                        HStack {
                            Text("Time")
                            Spacer()
                            Button {
                                windowViewModel.showMenu(.options)
                            } label: {
                                Image("cog")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 32, height: 32)
                            }
                        }
                        VStack {
                            Text("Round \(String(1))")
                                .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                            Text("New Turn")
                                .font(Font.custom("This-Cafe", size: TextSize.medium.rawValue))
                        }
                    }
                    .background(.clear)
                    .padding()
                    .frame(height: 32)
                    
                    Spacer()
                    
                    HStack {
                        getEggImage(eggType: EggType.golden)
                        
                        Text(String("8"))
                            .font(Font.custom("Coffee-Fills", size: TextSize.extraLarge.rawValue))
                            .offset(x: -15)
                        
                        Spacer()
                    }
                    CupZoneListView(playerIndex: 1)
                        .frame(height: 150)
                        .zIndex(-1)
                    
                    HStack {
                        Text("Ready")
                            .font(Font.custom("Coffee-Fills", size: TextSize.large.rawValue))
                            .offset(x: -15)
                        
                        Text("0")
                            .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                            .frame(height: 40)
                    }
                    
                    HStack {
                        Rectangle()
                            .opacity(0)
                        
                        NewHammerView()
                            .environment(hammerViewModel)
                            .zIndex(1)
                    }
                    .zIndex(2)
                    
                    HStack {
                        Text("Ready")
                            .font(Font.custom("Coffee-Fills", size: TextSize.large.rawValue))
                            .offset(x: -15)
                        
                        Text("0")
                            .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                            .frame(height: 40)
                    }
                    
                    CupZoneListView(playerIndex: 0)
                        .frame(height: 150)
                        .zIndex(-1)
                    
                    Spacer()
                    
                    ZStack {
                        HStack {
                            DragEggView(viewModel: normalDragEggViewModel)
                            
                            Spacer()
                            Text(String(8))
                                .font(Font.custom("Coffee-Fills", size: TextSize.extraLarge.rawValue))
                                .offset(x: 15)
                            DragEggView(viewModel: goldenDragEggViewModel)
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Set")
                                .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                                .foregroundColor(Color.TextColorPrimary)
                                .background(.clear)
                        }
                    }
                    
                    Rectangle()
                        .frame(height: 130)
                        .opacity(0)
                }
                VStack {
                    if windowViewModel.isInOptionsMenu {
                        NewOptionsView()
                    }
                    if windowViewModel.currentWindow == .tossCoin {
                        NewTossCoinView()
                    }
                }
                .zIndex(3)
                .frame(width: 300, height: 300)
            }
            .navigationBarBackButtonHidden(true)
            .background(Color.BackgroundColor)
        }
    }
}

#Preview {
    NewGameView()
        .environment(GameViewModel())
        .environment(WindowViewModel(defaultWindow: .tossCoin))
        .environment(OptionsViewModel())
}
