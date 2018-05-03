//
//  Format.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

enum Format: String {
    case standard
    case modern
    case legacy
    case commander
    case pauper

    static var allValues: [Format] = [.standard, .modern, .legacy, .commander, .pauper]
}
