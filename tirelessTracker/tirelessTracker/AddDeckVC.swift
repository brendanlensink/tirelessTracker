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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create the Eureka form
        form +++ Section("Log a match!")
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
                print("saved")
            }
    }
}
