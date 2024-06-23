//
//  GameView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/21/24.
//

import SwiftUI


let playerId = UUID()
struct GameView: View {
    let eggcups: [EggCupDropZone] = [
        EggCupDropZone(id: UUID(), playerId: playerId, isTargeted: false, eggCup: EggCup(id: UUID(), eggType: EggType.normal, isCovered: false)),
        EggCupDropZone(id: UUID(), playerId: playerId, isTargeted: true, eggCup: EggCup(id: UUID(), eggType: EggType.normal, isCovered: false)),
        EggCupDropZone(id: UUID(), playerId: playerId, isTargeted: false, eggCup: EggCup(id: UUID(), eggType: EggType.normal, isCovered: false)),
        EggCupDropZone(id: UUID(), playerId: playerId, isTargeted: false, eggCup: EggCup(id: UUID(), eggType: EggType.normal, isCovered: false))]
    var body: some View {
        return VStack {
            Rectangle()
                .frame(height: 50)
                .foregroundColor(.green)
            
            HStack {
                Image("golden_egg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("8")
                Rectangle()
                    .foregroundColor(.white)
            }
            VStack {
                Spacer()
                HStack {
                    ForEach(eggcups, id: \.id) { eggcup in
                        eggcup
                    }
                }
                .frame(height: 150.0)
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(.white)
                
                HStack {
                    Rectangle()

                    Image("hammer")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 128.0, height: 128.0)
                        .fixedSize(horizontal: true, vertical: true)
                }
                
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(.white)
                
                HStack {
                    Image("egg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image("golden_egg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image("golden_egg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image("golden_egg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(height: 150.0)
                Spacer()
            }
            HStack {
                Button {
                    print("Pressed Egg")
                } label: {
                    Image("egg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                Rectangle()
                    .foregroundColor(.white)
                Text("8")
                Button {
                    print("Pressed Golden Egg")
                } label: {
                    Image("golden_egg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GameView()
}
