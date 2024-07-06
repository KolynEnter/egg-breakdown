//
//  GamePopUpView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/5/24.
//

import SwiftUI

struct GamePopupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var popupControl: PopupHelper
    @State private var navigate = false
    
    init(popupControl: PopupHelper) {
        self.popupControl = popupControl
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(popupControl.message)
                Button {
                    if popupControl.isGoToMain {
//                        presentationMode.wrappedValue.dismiss()
                        navigate = true
                        popupControl.isGoToMain = false
                    }
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
            
            .navigationDestination(isPresented: $navigate) {
                ContentView()
            }
        }
    }
}
