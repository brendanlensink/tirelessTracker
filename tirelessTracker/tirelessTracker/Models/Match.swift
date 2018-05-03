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

class Match: Equatable {
    let id: MatchID
    let datetime: Int
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

    init() {
        id = Match.generateID()
        datetime = Date().millisecondsSince1970
    }

    init(id: MatchID, datetime: Int) {
        self.id = id
        self.datetime = datetime
    }

    var description: String {
        var description = ""

        if let event = event { description += "\(event) " }
        description += Date(milliseconds: datetime).formatted() + " "
        if let deck = deck { description += "\(deck.name) " }
        if let theirDeck = theirDeck { description += "vs. \(theirDeck)" }
        return description
    }

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

    static func == (lhs: Match, rhs: Match) -> Bool {
        return lhs.id == rhs.id
    }
}
