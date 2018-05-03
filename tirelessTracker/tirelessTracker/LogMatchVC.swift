//
//  LogMatchVC.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Eureka
import Foundation

class LogMatchVC: FormViewController {

    var match: Match!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
        animateScroll = true
        rowKeyboardSpacing = 20

        match = Match()

        // Create the Eureka form
        form +++ Section("Log a match!")
            <<< DateTimeInlineRow {
                $0.title = "Time"
                $0.value = Date()
            }
            <<< PushRow<Deck> {
                $0.title = "Deck"
                $0.selectorTitle = "Select a deck"
                $0.options = makeFakeDecks()

                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                // $0.value = initial selection
            }
            .cellUpdate { cell, row in
                cell.textLabel?.textColor = row.isValid ? .black : .red
            }
            <<< TextRow {
                $0.tag = "them"
                $0.title = "Their Name"
                $0.placeholder = "Jane Doe"

                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
            }.cellUpdate { cell, row in
                cell.titleLabel?.textColor = row.isValid ? .black : .red
            }
            <<< TextRow {
                $0.tag = "theirDeck"
                $0.title = "Their Deck"
                $0.placeholder = "Good Stuff"

                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
            }.cellUpdate { cell, row in
                cell.titleLabel?.textColor = row.isValid ? .black : .red
            }
            <<< GameRow { row in
                row.title = "Game 1"
                row.value = Game(matchID: self.match.id, order: 1)
                row.presentationMode = .show(controllerProvider: ControllerProvider.callback {
                    LogGameVC()
                }, onDismiss: { viewController in
                    guard let logGameVC = viewController as? LogGameVC else {
                        return
                    }
                    print("vC: \(logGameVC.row.value)")
                        _ = viewController.navigationController?.popViewController(animated: true)
                })
            }
            <<< ButtonRow {
                $0.title = "Save"
            }.onCellSelection { _, row in
                guard let errors = row.section?.form?.validate(), errors.isEmpty else {
                    return
                }

                print("ready!")
            }
    }

    func makeFakeDecks() -> [Deck] {
        let deck1 = Deck(id: 1, created: Date().millisecondsSince1970, name: "Test Deck 1", format: .legacy, version: nil)
        let deck2 = Deck(id: 2, created: Date().millisecondsSince1970, name: "Test Deck 2", format: .modern, version: nil)
        let deck3 = Deck(id: 3, created: Date().millisecondsSince1970, name: "Test Deck 3", format: .legacy, version: nil)
        return [deck1, deck2, deck3]
    }
}
