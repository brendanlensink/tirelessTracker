//
//  Deck.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Foundation
import RealmSwift

struct Deck: Equatable, CustomStringConvertible {
    let created: Int
    let name: String
    let format: Format
    let version: Int?

    var description: String {
        var desc = name
        if let version = version {
            desc +=  " v\(version)"
        }
        return desc + " - \(format.rawValue.capitalizingFirstLetter())"
    }

    func store() {
        let realmDeck = RealmDeck(value: [
            "created": created,
            "name": name,
            "format": format.rawValue,
            "version": version ?? 0
        ])
        try? Realm.shared.write {
            Realm.shared.add(realmDeck)
        }
    }

    static func getStored() -> [Deck] {
        var decks: [Deck] = []
        let realmDecks = Realm.shared.objects(RealmDeck.self)

        for realmDeck in realmDecks {
            let toDeck = realmDeck.toDeck()
            if !decks.contains(toDeck) { decks.append(toDeck) }
        }

        return decks
    }

    static func == (lhs: Deck, rhs: Deck) -> Bool {
        return lhs.name == rhs.name && lhs.format == rhs.format
    }
}
