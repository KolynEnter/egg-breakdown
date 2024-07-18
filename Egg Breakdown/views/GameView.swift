//
//  GameView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject private var game: EggBreakdownGame
    // Initialization order
    @State private var isShowDraggables: Bool = false
    @State private var isShowOptions: Bool = false
    @State private var opponentGoldenEggNumReferenceFrame: CGSize = .zero

    private let p1: Player
    private let p2: Player
    private var popupView: GamePopupView

    init(game: EggBreakdownGame, popupControl: PopupHelper, p1: Player, p2: Player) {
        self.game = game
        
        self.p1 = p1
        self.p2 = p2
        popupView = GamePopupView(popupControl: popupControl)
    }
    
    private var eggCupZoneListView1: EggCupZoneListView {
        EggCupZoneListView(game: game, startIndex: 0, playerId: p1.id, isShowDraggables: $isShowDraggables)
    }
    private var eggCupZoneListView2: EggCupZoneListView {
        EggCupZoneListView(game: game, startIndex: 4, playerId: p2.id, isShowDraggables: $isShowDraggables)
    }
    private var hammerView: HammerView {
        HammerView(game: game, targets: eggCupZoneListView2)
    }
    private var dragEgg1: DragEggCupView {
        DragEggCupView(game: game, targets: eggCupZoneListView1, eggType: EggType.golden)
    }
    private var dragEgg2: DragEggCupView {
        DragEggCupView(game: game, targets: eggCupZoneListView1, eggType: EggType.normal)
    }
    
    struct TimerView: View {
        @ObservedObject var gameFlowTimer: GameFlowTimer
        private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

        var body: some View {
            Text("\(gameFlowTimer.display)")
                .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                .onReceive(timer) { _ in
                    gameFlowTimer.updateCountdown()
                }
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .frame(height: 70)
                    .opacity(0)
                
                VStack {
                    HStack {
                        TimerView(gameFlowTimer: game.gameFlowTimer)
                        
                        Spacer()
                        
                        Button {
                            isShowOptions = true
                        } label: {
                            Image("cog")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                        }
                    }
                    
                    Text("Round \(String(game.round))")
                        .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                }
                .background(.clear)
                .padding()
                .frame(height: 32)
                
                HStack {
                    Image("golden_egg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: opponentGoldenEggNumReferenceFrame.width, height: opponentGoldenEggNumReferenceFrame.height)
                    
                    Text(String(game.getOtherPlayer().numOfGoldenEggs))
                        .font(Font.custom("Coffee-Fills", size: TextSize.extraLarge.rawValue))
                        .offset(x: -15)
                    
                    Spacer()
                }
                
                eggCupZoneListView2
                    .frame(height: 150.0)
                    .zIndex(-1)
                
                HStack {
                    Text(String(game.getOtherPlayer().isSetupReady ? "Ready": "---"))
                        .font(Font.custom("Coffee-Fills", size: TextSize.extraLarge.rawValue))
                        .offset(x: -15)
                    
                    Text("\(game.getOtherPlayer().score)")
                        .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                        .frame(height: 40)
                }
                
                HStack {
                    Rectangle()
                        .opacity(0)
                    
                    if isShowDraggables {
                        hammerView
                            .zIndex(1)
                    }
                }
                .zIndex(2)
                
                HStack {
                    Text(String(game.getLocalPlayer().isSetupReady ? "Ready": "---"))
                        .font(Font.custom("Coffee-Fills", size: TextSize.extraLarge.rawValue))
                        .offset(x: -15)
                    Text("\(game.getLocalPlayer().score)")
                        .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                        .frame(height: 40)
                }
                
                eggCupZoneListView1
                    .frame(height: 150.0)
                    .zIndex(-1)
                
                Spacer()
                
                ZStack {
                    HStack {
                        if isShowDraggables {
                            dragEgg2
                                .zIndex(1)
                                .background(GeometryReader { geometry in
                                    Color.clear
                                        .onAppear {
                                            opponentGoldenEggNumReferenceFrame = geometry.size
                                        }
                                })
                        }
                        
                        Spacer()
                        
                        if isShowDraggables {
                            Text(String(game.getLocalPlayer().numOfGoldenEggs))
                                .font(Font.custom("Coffee-Fills", size: TextSize.extraLarge.rawValue))
                                .offset(x: 15)
                            
                            dragEgg1
                                .zIndex(1)
                        }
                    }
                    Button {
                        game.getLocalPlayer().pressSetButton()
                    } label: {
                        Text("Set")
                            .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                            .foregroundColor(Color.TextColorPrimary)
                            .background(.clear)
                    }
                    .opacity(game.gamePhase == GamePhase.setupDefense ? 1 : 0)
                }
                .padding()
                Rectangle()
                    .frame(height: 70)
                    .opacity(0)
            }
            VStack {
                popupView
            }
            VStack {
                OptionsView(isShow: $isShowOptions, height: 300, width: 300)
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.BackgroundColor)
    }
}
