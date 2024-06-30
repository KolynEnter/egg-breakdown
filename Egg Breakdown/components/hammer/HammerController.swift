//
//  HammerManager.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/29/24.
//

import Foundation
import Combine

class HammerController: ObservableObject {
    @Published private(set) var offset = CGSize.zero

    private let model: HammerModel
    private let view: HammerView
    private let playerId: UUID
    private let targetZoneArea: EggCupZonesComponent
    private var cancellables = Set<AnyCancellable>()
    
    init(game: EggBreakdownGame, playerId: UUID, targetZoneArea: EggCupZonesComponent) {
        self.model = HammerModel()
        self.view = HammerView()
        self.playerId = playerId
        self.targetZoneArea = targetZoneArea
        
        model.$offset
            .sink { [weak self] newValue in
                self?.offset = newValue
            }
            .store(in: &cancellables)
    }
    
    func getView() -> HammerView {
        return view
    }
    
    func getOffset() -> CGSize {
        return model.offset
    }
    
    func getTargetIndex() -> Int {
        return model.targetIndex
    }
    
    func getCurrHammerFrame() -> CGRect {
        return model.getCurrHammerFrame()
    }
    
    func setFrame(newFrame: CGRect) -> Void {
        model.frame = newFrame
    }
    
    func setOffset(newOffset: CGSize) -> Void {
        model.offset = newOffset
    }
    
    func setTargetIndex(newIndex: Int) -> Void {
        model.targetIndex = newIndex
    }
}
