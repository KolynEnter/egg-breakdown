//
//  GameToPlayer.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/24/24.
//

struct GameToPlayer {
    let game: EggBreakdownGame
    let gameBreakEgg: (Int)  -> Void
    let endAttackTurn: (Player) -> Void
}
