//
//  TutorialModel.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/19/24.
//

import Foundation

struct RulesModel {
    private let lines: [String] = [
        "The goal of game “Egg Breakdown” is to gain a higher score than your opponent within 3 rounds.",
        "Before each round, players should set up defenses. To withstand hammer attacks, swap regular eggs with golden ones.",
        "Then, you and your opponent will each have a turn to attack. You earn points by cracking your opponent’s egg with the hammer.",
        "Be wary! The hammer cannot break golden eggs.",
        "Both you and your opponent will start with eight golden eggs.",
        "If there’s a tie after three rounds, the player with the most golden eggs wins."
    ]
    private let images: [String] = [
        "tutorial1",
        "tutorial2",
        "tutorial3",
        "tutorial4",
        "tutorial5",
        "tutorial6",
    ]
    var lineCount: Int {
        get {
            return lines.count
        }
    }
    func getLine(at index: Int) -> String {
        return lines[index]
    }
    func getImage(at index: Int) -> String {
        return images[index]
    }
}
