//
//  Hammer.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/24/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct Hammer: View, Codable, Hashable, Transferable {
    let playerId: UUID
    
    var body: some View {
        return ZStack {
            Image("hammer")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 128.0, height: 128.0)
                .fixedSize(horizontal: true, vertical: true)
        }
    }
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .hammer)
    }
}

extension UTType {
    static let hammer = UTType(exportedAs: "KolynEnterprise.Egg-Breakdown.hammer")
}
