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
    @State private var isDarkModeOn = false
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @ObservedObject var bgmPlayer: MusicPlayerViewModel
    @ObservedObject var sfxPlayer: MusicPlayerViewModel
    
    let height: CGFloat
    let width: CGFloat
    
    var ToggleThemeView: some View {
        Toggle("Dark Mode", isOn: $isDarkModeOn).onChange(of: isDarkModeOn) { (oldState, newState)  in
            changeDarkMode(state: newState)
        }.labelsHidden()
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Text("BGM")
                    .padding()
                    .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)
                AudioSlider(musicPlayer: bgmPlayer)
            }
            
            HStack {
                Text("SFX")
                    .padding()
                    .font(Font.custom("This-Cafe", size: TextSize.extraLarge.rawValue))
                    .foregroundColor(Color.TextColorPrimary)
                    .background(.clear)
                AudioSlider(musicPlayer: sfxPlayer)
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
                isShow = false
            } label: {
                Text("Close")
                    .padding()
                    .font(Font.custom("This-Cafe", size: TextSize.large.rawValue))
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
        .onAppear(perform: {
            setAppTheme()
        })
    }
    
    private func setAppTheme() -> Void {
      //MARK: use saved device theme from toggle
      isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
      changeDarkMode(state: isDarkModeOn)
      //MARK: or use device theme
      /*if (colorScheme == .dark)
      {
        isDarkModeOn = true
      }
      else{
        isDarkModeOn = false
      }
      changeDarkMode(state: isDarkModeOn)*/
    }
    
    private func changeDarkMode(state: Bool) -> Void {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
}
