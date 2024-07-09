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
        "Before each round, both you and your opponent will need to set up defenses. To withstand hammer attacks, swap regular eggs with golden ones.",
        "Once your defenses are set up, you can send a message to your opponent.",
        "Then, you and your opponent will each have a turn to attack. You earn points by cracking your opponent’s egg with the hammer.",
        "Be wary! The hammer cannot break golden eggs.",
        "Both you and your opponent will start with eight golden eggs.",
        "If there’s a tie after three rounds, the player with the most golden eggs wins."
    ]

    var body: some View {
        VStack {
            Spacer()
            
            Text("\(String(linePointer + 1)) / \(lines.count)")
                .font(Font.custom("This-Cafe", size: 32))
                .foregroundColor(Color.TextColorPrimary)
                .background(.clear)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    decrementLinePointer()
                } label: {
                    Text("<")
                        .font(Font.custom("This-Cafe", size: 64))
                        .foregroundColor(Color.TextColorPrimary)
                        .background(.clear)
                }
                
                Rectangle()
                    .frame(width: 20)
                    .opacity(0)
                
                NaturalTextView(text: lines[linePointer], customFontName: "Coffee-Fills", fontSize: 18)
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)

                Rectangle()
                    .frame(width: 20)
                    .opacity(0)
                
                Button {
                    incrementLinePointer()
                } label: {
                    Text(">")
                        .font(Font.custom("This-Cafe", size: 64))
                        .foregroundColor(Color.TextColorPrimary)
                        .background(.clear)
                }
                Spacer()
            }
                
            Spacer()
            
            Button {
                isShow = false
            } label: {
                Text("Close")
                    .font(Font.custom("This-Cafe", size: 32))
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)
            }
            
            Spacer()
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
