//
//  AddDeckVC.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Eureka
import Foundation
import RealmSwift

class AddDeckVC: FormViewController {

    private var decks = Set<Deck>()

    override func viewDidLoad() {
        super.viewDidLoad()

        decks = Set(Deck.getStored())

        // Create the Eureka form
        form +++ Section("Add a new deck!")
            <<< TextRow("name") {
                $0.title = "Deck Name"
                $0.placeholder = "Good Stuff"

                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
            }.cellUpdate { cell, row in
                    cell.textLabel?.textColor = row.isValid ? .black : .red
            }
            <<< PushRow<Format> {
                $0.tag = "format"
                $0.title = "Format"
                $0.selectorTitle = "Pick A Format"
                $0.options = Format.allValues

                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
            }.cellUpdate { cell, row in
                    cell.textLabel?.textColor = row.isValid ? .black : .red
            }
            <<< ButtonRow {
                $0.title = "Save"
            }.onCellSelection { _, row in
                let values = self.form.values()
                guard let errors = row.section?.form?.validate(),
                        errors.isEmpty,
                        let name = values["name"] as? String,
                        let format = values["format"] as? Format else {
                    return
                }

                let newDeck = Deck(created: Date().millisecondsSince1970, name: name, format: format, version: 0)
                newDeck.store()
                self.decks.insert(newDeck)
                self.form.last! <<< LabelRow {
                    $0.title = newDeck.description
                }

                self.reloadDecks()
            }

        +++ Section("Decks")

        for deck in decks {
            form.last! <<< addDeckRow(for: deck)
        }
    }

    private func reloadDecks() {
        for row in form.rows {
            row.baseValue = nil
            row.reload()
        }

        tableView.reloadData()
    }

    private func addDeckRow(for deck: Deck) -> LabelRow {
        return LabelRow {
            $0.title = deck.description

            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { _, _, completionHandler in
                self.decks.remove(deck)
                deck.delete()
                completionHandler?(true)
            }
            deleteAction.image = UIImage(named: "icon-trash")
            $0.trailingSwipe.actions = [deleteAction]
        }
    }
}
