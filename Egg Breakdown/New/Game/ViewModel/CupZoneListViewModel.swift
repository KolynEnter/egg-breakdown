//
//  CupZoneListViewModel.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/20/24.
//

import Foundation

@Observable class CupZoneListViewModel {
    var model = CupZoneListModel()
    
    func changeEgg(at index: Int, to type: EggType) {
        model.dropZoneEggType[index] = type
    }
    
    func targetEgg(at index: Int) {
        model.isZoneTargeted[index] = true
    }
    
    func unTargetEgg(at index: Int) {
        model.isZoneTargeted[index] = false
    }
    
    func setCoverAlphaToZero(index: Int) {
        model.coverAlphaValue[index] = 0
    }
    
    func setAllCoverAlphaToHalf() {
        model.coverAlphaValue = Array(repeating: 0.5, count: 4)
    }
    
    func setAllCoverAlphaToOne() {
        model.coverAlphaValue = Array(repeating: 1, count: 4)
    }
    
    func setFrame(at index: Int, newFrame: CGRect) {
        model.cupFrames[index] = newFrame
    }
    
    func reset() {
        model.isZoneTargeted = Array(repeating: false, count: 4)
        model.coverAlphaValue = Array(repeating: 0, count: 4)
        model.dropZoneEggType = Array(repeating: EggType.normal, count: 4)
    }
}
