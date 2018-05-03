//
//  Match.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Foundation
import RealmSwift

typealias MatchID = Identifier<Match>

class Match {
    let id: MatchID = Match.generateID()
    let datetime: Int = Date().millisecondsSince1970
    var deck: Deck?
    var theirDeck: String?
    var result: MatchResult {
        // Actually make this work
        return .win
    }
    var games: [Game] = []

    var event: String?
    var theirName: String?
    var wonRoll: Bool = true
    var notes: String?

    init() {}

    private static func generateID() -> MatchID {
        return MatchID(rawValue: UUID().uuidString + String(Date().millisecondsSince1970))
    }

    func store() {
        guard let myDeck = deck else {
            debugPrint("Not storing, deck is nil")
            return
        }

        let myRealmDeck = RealmDeck(value: [
            "created": myDeck.created,
            "format": myDeck.format.rawValue,
            "name": myDeck.name
        ])

        let realmMatch = RealmMatch(value: [
            "id": id.rawValue,
            "datetime": datetime,
            "deck": myRealmDeck,
            "theirDeck": theirDeck ?? ""
        ])

        for game in games {
            let realmGame = RealmGame(value: [
                "matchID": id.rawValue,
                "order": game.order,
                "result": game.result?.rawValue ?? "",
                "wentFirst": game.wentFirst,
                "yourHand": game.yourHand,
                "theirHand": game.theirHand,
                "notes": game.notes ?? ""
            ])
            realmMatch.games.append(realmGame)
        }

        try? Realm.shared.write {
            Realm.shared.add(realmMatch)
        }
    }
}
