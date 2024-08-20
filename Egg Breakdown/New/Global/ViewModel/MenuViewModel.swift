//
//  MenuViewModel.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/19/24.
//

import Foundation

enum MenuType {
    case popup
    case settings
    case rules
    case options
    case exitGame
    case none
}

@Observable class MenuViewModel {
    var currentMenu: MenuType = .none
    var popupMessage: String = ""
    
    init(defaultMenu: MenuType = .none) {
        currentMenu = defaultMenu
    }
    
    func showMenu(_ menu: MenuType) {
        currentMenu = menu
    }
}
