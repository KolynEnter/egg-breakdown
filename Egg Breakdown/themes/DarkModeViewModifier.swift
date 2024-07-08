//
//  DarkModeViewModifier.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/8/24.
//

// https://stackoverflow.com/a/69109218

import Foundation
import SwiftUI

struct DarkModeViewModifier: ViewModifier {
    @ObservedObject var appThemeViewModel: AppThemeViewModel
    
    public func body(content: Content) -> some View {
        content
            .preferredColorScheme(appThemeViewModel.isDarkMode ? .dark : .light)
    }
}
