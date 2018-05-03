//
//  RealmMatch.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMatch: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var datetime: Int = -1
    @objc dynamic var deck: RealmDeck?
    @objc dynamic var theirDeck: String?
    let result = RealmOptional<Int>()
    let games = List<RealmGame>()

    func toMatch() -> Match {
        var toGames: [Game] = []
        for game in games {
            toGames.append(game.toGame())
        }

        let toMatch = Match()
        toMatch.deck = deck?.toDeck()
        toMatch.theirDeck = theirDeck
        toMatch.games = toGames
        return toMatch
    }
}
