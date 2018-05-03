//
//  RealmDeck.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDeck: Object {
    @objc dynamic var created: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var format: String = ""
    let version = RealmOptional<Int>()

    func toDeck() -> Deck {
        return Deck(created: created, name: name, format: Format(rawValue: format)!, version: version.value)
    }
}
