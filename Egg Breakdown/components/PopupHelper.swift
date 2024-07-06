//
//  PopUpHelper.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/4/24.
//

import Foundation

// https://www.reddit.com/r/SwiftUI/comments/103gma5/comment/j361l5w/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

class PopupHelper: ObservableObject {
    @Published var showPopup: Bool = false
    @Published var message: String = ""
}
