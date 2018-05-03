//
//  LogGameVC.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Eureka
import UIKit

class LogGameVC: FormViewController, TypedRowControllerType {

    // protocol conformance
    var row: RowOf<Game>!
    var onDismissCallback: ((UIViewController) -> Void)?

    convenience public init(callback: ((UIViewController) -> Void)?) {
        self.init(nibName: nil, bundle: nil)
        onDismissCallback = callback
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section("Log Game")
            <<< SegmentedRow<MatchResult>("result") {
                $0.title = "Result"
                $0.options = MatchResult.allValues

                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
            }.cellUpdate { cell, row in
                cell.titleLabel?.textColor = row.isValid ? .black : .red
            }
            <<< SwitchRow("start") {
                $0.title = "Played First"
                $0.value = true
                $0.onChange {
                    $0.title = $0.value == true ? "Played First" : "Played Second"
                    $0.reload()
                }
            }
            <<< makeHandStepper(tag: "yourHand", title: "Your Hand")
            <<< makeHandStepper(tag: "theirHand", title: "Their Hand")
            <<< TextAreaRow("notes")
            <<< ButtonRow {
                $0.title = "Done"
            }.onCellSelection { _, row in
                guard let errors = row.section?.form?.validate(), errors.isEmpty, let game = self.row.value else {
                    return
                }

                let values = self.form.values()
                // I'm pretty sure this can be done better with codable
                if let start = values["start"] as? Bool { game.wentFirst = start }
                if let result = values["result"] as? MatchResult { game.result = result }
                if let yourHand = values["yourHand"] as? Int { game.yourHand = yourHand }
                if let theirHand = values["theirHand"] as? Int { game.theirHand = theirHand }
                if let notes = values["notes"] as? String { game.notes = notes }

                self.onDismissCallback?(self)
            }
    }

    private func makeHandStepper(tag: String, title: String) -> StepperRow {
        return  StepperRow(tag) {
            $0.title = title
            $0.value = 7

            $0.onChange {
                guard let value = $0.value else { return }

                switch Int(value) {
                case Int.min ..< 0: $0.value = 0
                case 8...Int.max: $0.value = 7
                default: return
                }
                $0.reload()
            }

            $0.cell.stepper.stepValue = 1
            $0.displayValueFor = { value in
                guard let value = value else { return nil }
                return "\(Int(value))"
            }
        }
    }
}
