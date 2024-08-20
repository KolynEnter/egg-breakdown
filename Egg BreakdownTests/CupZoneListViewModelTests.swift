//
//  CupZoneListViewModelTests.swift
//  Egg BreakdownTests
//
//  Created by Jianxin Lin on 8/20/24.
//

import XCTest
@testable import Egg_Breakdown

final class CupZoneListViewModelTests: XCTestCase {
    var viewModel: CupZoneListViewModel!
    
    override func setUpWithError() throws {
        viewModel = CupZoneListViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testExample() throws {
        viewModel.setAllCoverAlphaToHalf()
        XCTAssertEqual(viewModel.model.coverAlphaValue, Array(repeating: 0.5, count: 4))
    }
}
