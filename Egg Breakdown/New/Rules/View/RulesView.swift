//
//  NewTutorialView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/19/24.
//

import SwiftUI

struct RulesView: View {
    @State private var linePointer: Int = 0
    @Environment(MenuViewModel.self) var menuViewModel: MenuViewModel
    
    private var model = RulesModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(String(linePointer + 1)) / \(model.lineCount)")
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
                    
                    NaturalTextView(text: model.getLine(at: linePointer), customFontName: "Coffee-Fills", fontSize:
                                        model.lineCount <= model.getLine(at: 0).count ?
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
                    menuViewModel.showMenu(.none)
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
                
                Image(model.getImage(at: linePointer))
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            .zIndex(1)
        }
        .frame(width: 300, height: 300)
        .background(Color.BackgroundColor)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
        .opacity(menuViewModel.currentMenu == .rules ? 1 : 0)
        .onChange(of: menuViewModel.currentMenu) {
            linePointer = 0
        }
    }
    
    private func decrementLinePointer() -> Void {
        linePointer -= 1
        if linePointer < 0 {
            linePointer = model.lineCount - 1
        }
    }
    
    private func incrementLinePointer() -> Void {
        linePointer += 1
        if linePointer > model.lineCount - 1 {
            linePointer = 0
        }
    }
}

#Preview {
    RulesView()
        .environment(MenuViewModel(defaultMenu: .rules))
}
