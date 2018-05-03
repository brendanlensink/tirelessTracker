//
//  Match.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Foundation

typealias MatchID = Identifier<Match>

class Match {
    let id: MatchID = Match.generateID()
    let datetime: Int = Date().millisecondsSince1970
    var deck: Deck?
    var theirDeck: Deck?
    var result: MatchResult? // TODO: change to computed property
    var games: [Game] = []

    var event: String?
    var theirName: String?
    var wonRoll: Bool = true
    var notes: String?

    init() {}

    private static func generateID() -> MatchID {
        return MatchID(rawValue: UUID().uuidString + String(Date().millisecondsSince1970))
    }
}
