//
//  SettingsView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/8/24.
//

import SwiftUI

// Adjust volume (bgm / sfx)
// Change theme

struct SettingsView: View {
    @Binding var isShow: Bool
    
    let height: CGFloat
    let width: CGFloat
    
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Text("Audio")
                    .padding()
                    .font(Font.custom("This-Cafe", size: 32))
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)
            }
            
            Button {
                
            } label: {
                Text("Theme")
                    .padding()
                    .font(Font.custom("This-Cafe", size: 32))
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)
            }
            
            Button {
                isShow = false
            } label: {
                Text("Close")
                    .padding()
                    .font(Font.custom("This-Cafe", size: 32))
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)
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
