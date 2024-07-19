//
//  TutorialView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/8/24.
//

import SwiftUI

struct TutorialView: View {
    @Binding var isShow: Bool
    @State var linePointer: Int = 0
    
    let height: CGFloat
    let width: CGFloat
    
    private let lines: [String] = [
        "The goal of game “Egg Breakdown” is to gain a higher score than your opponent within 3 rounds.",
        "Before each round, players should set up defenses. To withstand hammer attacks, swap regular eggs with golden ones.",
        "Then, you and your opponent will each have a turn to attack. You earn points by cracking your opponent’s egg with the hammer.",
        "Be wary! The hammer cannot break golden eggs.",
        "Both you and your opponent will start with eight golden eggs.",
        "If there’s a tie after three rounds, the player with the most golden eggs wins."
    ]
    private let images: [String] = [
        "tutorial1",
        "tutorial2",
        "tutorial3",
        "tutorial4",
        "tutorial5",
        "tutorial6",
    ]

    var body: some View {
        ZStack {
            VStack {
                Text("\(String(linePointer + 1)) / \(lines.count)")
                    .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                    .foregroundColor(Color.TextColorPrimary)
                
                HStack {
                    Button {
                        decrementLinePointer()
                    } label: {
                        Text("<")
                            .font(Font.custom("This-Cafe", size: 64))
                            .foregroundColor(Color.TextColorPrimary)
                            .background(.clear)
                    }
                    
                    Rectangle()
                        .frame(width: 10)
                        .opacity(0)
                    
                    NaturalTextView(text: lines[linePointer], customFontName: "Coffee-Fills", fontSize:
                                        lines[linePointer].count <= lines[0].count ?
                                    TextSize.medium.rawValue : TextSize.smallMedium.rawValue)
                        .foregroundColor(Color.TextColorPrimary)
                        .background(.clear)
                    
                    Rectangle()
                        .frame(width: 10)
                        .opacity(0)
                    
                    Button {
                        incrementLinePointer()
                    } label: {
                        Text(">")
                            .font(Font.custom("This-Cafe", size: TextSize.ultraLarge.rawValue))
                            .foregroundColor(Color.TextColorPrimary)
                            .background(.clear)
                    }
                    
                }
                .frame(height: 150)
                .offset(y: -20)

                Spacer()
                
                Button {
                    isShow = false
                } label: {
                    Text("Close")
                        .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                        .foregroundColor(Color.TextColorPrimary)
                        .background(.clear)
                }
            }
            .padding()
            
            VStack {
                Rectangle()
                    .frame(height: 100)
                    .opacity(0)
                
                Image(images[linePointer])
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            .zIndex(1)
        }
        .frame(width: width, height: height)
        .background(Color.BackgroundColor)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
        .opacity(isShow ? 1 : 0)
        .onChange(of: isShow) {
            linePointer = 0
        }
    }
    
    private func decrementLinePointer() -> Void {
        linePointer -= 1
        if linePointer < 0 {
            linePointer = lines.count - 1
        }
    }
    
    private func incrementLinePointer() -> Void {
        linePointer += 1
        if linePointer > lines.count - 1 {
            linePointer = 0
        }
    }
}
