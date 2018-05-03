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
//    @objc dynamic var name: String? = nil
//    let age = RealmOptional<Int>()
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

class RealmDeck: Object {
    @objc dynamic var created: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var format: String = ""
    let version = RealmOptional<Int>()

    func toDeck() -> Deck {
        return Deck(created: created, name: name, format: Format(rawValue: format)!, version: version.value)
    }
}

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
