//
//  HammerModel.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/29/24.
//

import Foundation

class HammerModel: ObservableObject {
    @Published var offset = CGSize.zero
    
    var frame = CGRect.zero
    var targetIndex: Int = 0
    
    func getCurrHammerFrame() -> CGRect {
        return CGRect(x: offset.width + frame.minX,
                      y: offset.height + frame.minY,
                      width: frame.width,
                      height: frame.height)
    }
}
