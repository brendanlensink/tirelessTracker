//
//  Game.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Foundation

typealias GameID = Identifier<Game>

class Game: Equatable {
    var matchID: MatchID
    var order: Int
    var result: MatchResult?
    var wentFirst: Bool = true
    var yourHand: Int = 7
    var theirHand: Int = 7
    var notes: String?

    init(matchID: MatchID, order: Int) {
        self.matchID = matchID
        self.order = order
    }

    var isComplete: Bool {
        return result != nil
    }

    var description: String {
        guard let result = result else {
            return "Incomplete"
        }

        return "\(result.title)"
    }

    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.matchID == rhs.matchID
            && lhs.order == rhs.order
    }
}
