//
//  AppThemeViewModel.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/8/24.
//

// https://stackoverflow.com/a/69109218

import Foundation
import SwiftUI

class AppThemeViewModel: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    
    func toggleTheme() {
        isDarkMode.toggle()
    }
}
