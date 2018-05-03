//
//  RealmGame.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Foundation
import RealmSwift

class RealmGame: Object {
    @objc dynamic var matchID: String = ""
    @objc dynamic var order: Int = -1
    @objc dynamic var result: String = ""
    @objc dynamic var wentFirst: Bool = true
    @objc dynamic var yourHand = 7
    @objc dynamic var theirHand = 7
    @objc dynamic var notes: String?

    func toGame() -> Game {
        let toGame = Game(matchID: MatchID(rawValue: matchID), order: order)
        toGame.result = MatchResult(rawValue: result)
        toGame.wentFirst = wentFirst
        toGame.yourHand = yourHand
        toGame.theirHand = theirHand
        toGame.notes = notes

        return toGame
    }
}
