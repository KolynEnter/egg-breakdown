//
//  Draggable_EggCup.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/22/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct DraggableEggCup: View, Codable, Hashable, Transferable {
    let id: UUID
    let playerId: UUID
    let eggType: EggType
    
    var body: some View {
        return ZStack {
            getEggImage(eggType: eggType)
        }
    }
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .draggableEggCup)
    }
}

extension UTType {
    static let draggableEggCup = UTType(exportedAs: "KolynEnterprise.Egg-Breakdown.draggableEggCup")
}
