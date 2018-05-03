//
//  ViewMatchVC.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Eureka
import Foundation

class ViewMatchVC: FormViewController, TypedRowControllerType {
    // protocol conformance
    var row: RowOf<Match>!
    var onDismissCallback: ((UIViewController) -> Void)?

    convenience public init(callback: ((UIViewController) -> Void)?) {
        self.init(nibName: nil, bundle: nil)
        onDismissCallback = callback
    }

}
