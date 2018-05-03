//
//  Date+ToMS.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Foundation

extension Date {
    var millisecondsSince1970: Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }

    func formatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/MM HH:mm"

        return dateFormatter.string(from: self)
    }
}
