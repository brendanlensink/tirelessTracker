//
//  Identifier.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Foundation

struct Identifier<T>: RawRepresentable {
    typealias RawValue = String

    let text: String

    init(rawValue: RawValue) {
        text = rawValue
    }

    var rawValue: RawValue {
        return text
    }
}

extension Identifier: Equatable {
    // RawRepresentable can automatically conform
}

extension Identifier: Hashable {
    var hashValue: Int {
        return text.hashValue
    }
}

extension Identifier: CustomDebugStringConvertible {
    var debugDescription: String {
        return text
    }
}
