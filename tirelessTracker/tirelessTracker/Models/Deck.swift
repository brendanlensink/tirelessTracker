//
//  Deck.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Foundation
import RealmSwift

struct Deck {
    let created: Int
    let name: String
    let format: Format
    let version: Int?

    func store() {
        try? Realm.shared.write {
            Realm.shared.add(toRealmDeck())
        }
    }

    func delete() {
        try? Realm.shared.write {
            let deck = Realm.shared.objects(RealmDeck.self).filter("name = '\(name)' AND created = \(created)")
            Realm.shared.delete(deck)
        }
    }

    private func toRealmDeck() -> RealmDeck {
        return RealmDeck(value: [
            "created": created,
            "name": name,
            "format": format.rawValue,
            "version": version ?? 0
        ])
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
}

extension Deck: CustomStringConvertible {
    var description: String {
        var desc = name
        if let version = version {
            desc +=  " v\(version)"
        }
        return desc + " - \(format.rawValue.capitalizingFirstLetter())"
    }
}

extension Deck: Equatable {
    static func == (lhs: Deck, rhs: Deck) -> Bool {
        return lhs.name == rhs.name && lhs.format == rhs.format
    }
}

extension Deck: Hashable {
    var hashValue: Int {
        return created + name.hashValue
    }
}
