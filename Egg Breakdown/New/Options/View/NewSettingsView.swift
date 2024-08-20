//
//  SettingsView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/19/24.
//

import SwiftUI

struct NewSettingsView: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Environment(MenuViewModel.self) var menuViewModel: MenuViewModel
    @State private var isDarkModeOn = false

    private var ToggleThemeView: some View {
        Toggle("Dark Mode", isOn: $isDarkModeOn).onChange(of: isDarkModeOn) { (oldState, newState)  in
            changeDarkMode(state: newState)
        }.labelsHidden()
            .tint(Color.TextColorSecondary)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("BGM")
                    .padding()
                    .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)
                NewAudioSlider(audioType: .bgm)
            }
            
            HStack {
                Text("SFX")
                    .padding()
                    .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)
                NewAudioSlider(audioType: .sfx)
            }
            
            HStack {
                Text("Theme")
                    .padding()
                    .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)
                ToggleThemeView
            }
            
            Button {
                menuViewModel.showMenu(.none)
            } label: {
                Text("Close")
                    .padding()
                    .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)
            }
        }
        .frame(width: 350, height: 300)
        .background(Color.BackgroundColor)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
        .opacity(menuViewModel.currentMenu == .settings ? 1 : 0)
        .onAppear(perform: {
            setAppTheme()
        })
    }
    
    private func setAppTheme() -> Void {
      isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
      changeDarkMode(state: isDarkModeOn)
    }
    
    private func changeDarkMode(state: Bool) -> Void {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
}

#Preview {
    NewSettingsView()
        .environment(MenuViewModel(defaultMenu: .settings))
        .environment(OptionsViewModel())
}
