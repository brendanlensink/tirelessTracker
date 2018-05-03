//
//  Deck.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Foundation

struct Deck: Equatable, CustomStringConvertible {
    let id: Int
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

    static func == (lhs: Deck, rhs: Deck) -> Bool {
        return lhs.id == rhs.id
    }
}
