//
//  ViewMatchRow.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import Eureka
import Foundation

final class ViewMatchRow: OptionsRow<PushSelectorCell<Match>>, PresenterRowType, RowType {
    typealias PresenterRow = ViewMatchVC

    /// Defines how the view controller will be presented, pushed, etc.
    var presentationMode: PresentationMode<PresenterRow>?

    /// Will be called before the presentation occurs.
    var onPresentCallback: ((FormViewController, PresenterRow) -> Void)?

    required init(tag: String?) {
        super.init(tag: tag)
        presentationMode = .show(
            controllerProvider: ControllerProvider.callback {
                ViewMatchVC { _ in }
            },
            onDismiss: { viewController in
                _ = viewController.navigationController?.popViewController(animated: true)
        }
        )

        displayValueFor = {
            guard let match = $0 else { return "" }
            return match.description
        }
    }

    /**
     Extends `didSelect` method
     */
    open override func customDidSelect() {
        super.customDidSelect()
        guard let presentationMode = presentationMode, !isDisabled else { return }
        if let controller = presentationMode.makeController() {
            controller.row = self
            controller.title = selectorTitle ?? controller.title
            onPresentCallback?(cell.formViewController()!, controller)
            presentationMode.present(controller, row: self, presentingController: self.cell.formViewController()!)
        } else {
            presentationMode.present(nil, row: self, presentingController: self.cell.formViewController()!)
        }
    }

    /**
     Prepares the pushed row setting its title and completion callback.
     */
    open override func prepare(for segue: UIStoryboardSegue) {
        super.prepare(for: segue)
        guard let rowVC = segue.destination as? PresenterRow else { return }
        rowVC.title = selectorTitle ?? rowVC.title
        rowVC.onDismissCallback = presentationMode?.onDismissCallback ?? rowVC.onDismissCallback
        onPresentCallback?(cell.formViewController()!, rowVC)
        rowVC.row = self
    }
}
