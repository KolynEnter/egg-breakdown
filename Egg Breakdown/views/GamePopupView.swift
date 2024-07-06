//
//  GamePopUpView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/5/24.
//

import SwiftUI

struct GamePopupView: View {
    @ObservedObject private var popupControl: PopupHelper
    
    init(popupControl: PopupHelper) {
        self.popupControl = popupControl
    }
    
    var body: some View {
        return VStack {
            Text(popupControl.message)
            Button {
                popupControl.showPopup = false
                popupControl.message = ""
            } label: {
                Text("Close")
            }
        }
        .frame(width: 300, height: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
        .opacity(popupControl.showPopup ? 1 : 0)
    }
}
