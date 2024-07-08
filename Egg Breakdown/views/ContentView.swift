//
//  ContentView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var appThemeViewModel: AppThemeViewModel  = AppThemeViewModel()
    
    var body: some View {
        MainView(appThemeViewModel: appThemeViewModel)
            .navigationBarBackButtonHidden(true)
            .modifier(DarkModeViewModifier(appThemeViewModel: appThemeViewModel))
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//       ContentView()
//          .preferredColorScheme(.dark)
//            
//        ContentView()
//            .preferredColorScheme(.light)
//    }
//}
