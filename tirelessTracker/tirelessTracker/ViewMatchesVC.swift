//
//  ViewMatchesVC.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Eureka
import Foundation
import RealmSwift

class ViewMatchesVC: FormViewController {

    var matches: [Match] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section("Matches")

        let realmMatches = Realm.shared.objects(RealmMatch.self)
        for realmMatch in realmMatches {
            let match = realmMatch.toMatch()
            matches.append(match)

            form.last! <<< ViewMatchRow {
                $0.title = match.theirName
                $0.value = match
                $0.presentationMode = .show(controllerProvider: ControllerProvider.callback {
                    LogMatchVC()
                }, onDismiss: { viewController in
                    _ = viewController.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
}
