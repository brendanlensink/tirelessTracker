//
//  MatchResult.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Foundation

enum MatchResult {
    case win
    case loss
    case draw

    var shortTitle: String {
        switch self {
        case .win: return "W"
        case .loss: return "L"
        case .draw: return "D"
        }
    }

    static var allValues: [MatchResult] {
        return [.win, .loss, .draw]
    }
}
