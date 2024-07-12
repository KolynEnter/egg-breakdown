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
    @State private var isShowTutorial: Bool = false
    @State private var opponentGoldenEggNumReferenceFrame: CGSize = .zero
    @State private var navigate = false

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
    
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .frame(height: 70)
                    .opacity(0)
                
                VStack {
                    HStack {
                        Text("00:30")
                            .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                        Spacer()
                        
                        Button {
                            isShowTutorial = true
                        } label: {
                            Text("Rules")
                                .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                                .foregroundColor(Color.TextColorPrimary)
                                .background(.clear)
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
                    NavigationStack {
                        Button {
                            navigate = true
                        } label: {
                            Image("exit")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: opponentGoldenEggNumReferenceFrame.width, height: opponentGoldenEggNumReferenceFrame.height)
                        }
                        
                        .navigationDestination(isPresented: $navigate) {
                            ContentView()
                        }
                    }
                }
                
                eggCupZoneListView2
                    .frame(height: 150.0)
                    .zIndex(-1)
                
                Text("\(game.getOtherPlayer().score)")
                    .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                    .frame(height: 40)
                
                HStack {
                    Rectangle()
                        .opacity(0)
                    
                    if isShowDraggables {
                        hammerView
                            .zIndex(1)
                    }
                }
                .zIndex(2)
                
                Text("\(game.getLocalPlayer().score)")
                    .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                    .frame(height: 40)
                
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
                TutorialView(isShow: $isShowTutorial, height: 300, width: 300)
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.BackgroundColor)
    }
}
