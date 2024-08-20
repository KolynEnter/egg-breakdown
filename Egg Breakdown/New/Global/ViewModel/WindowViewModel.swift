//
//  WindowViewModel.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/19/24.
//

import Foundation

enum WindowType {
    case popup
    case settings
    case rules
    case options
    case exitGame
    case tossCoin
    case none
}

@Observable class WindowViewModel {
    private(set) var currentWindow: WindowType = .none
    var popupMessage: String = ""
    var isInOptionsMenu: Bool {
        get {
            return currentWindow == .options ||
                    currentWindow == .settings ||
                    currentWindow == .rules ||
                    currentWindow == .exitGame
        }
    }
    
    init(defaultWindow: WindowType = .none) {
        currentWindow = defaultWindow
    }
    
    func showMenu(_ menu: WindowType) {
        currentWindow = menu
    }
}
