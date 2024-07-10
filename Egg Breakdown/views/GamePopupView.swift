//
//  GamePopUpView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/5/24.
//

import SwiftUI

struct GamePopupView: View {
    @ObservedObject private var popupControl: PopupHelper
    @State private var navigate = false
    
    init(popupControl: PopupHelper) {
        self.popupControl = popupControl
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text(popupControl.message)
                    .font(Font.custom("Coffee-Fills", size: TextSize.large.rawValue))
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)
                
                Spacer()
                
                Button {
                    if popupControl.isGoToMain {
                        navigate = true
                        popupControl.isGoToMain = false
                    }
                    popupControl.showPopup = false
                    popupControl.message = ""
                } label: {
                    Text("Close")
                        .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                        .foregroundColor(Color.TextColorPrimary)
                        .background(.clear)
                }
                Spacer()
            }
            .frame(width: 300, height: 200)
            .background(Color.BackgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
            .opacity(popupControl.showPopup ? 1 : 0)
            
            .navigationDestination(isPresented: $navigate) {
                ContentView()
            }
        }
    }
}
