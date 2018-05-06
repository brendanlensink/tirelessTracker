//
//  AppDelegate.swift
//  tirelessTracker
//
//  Created by Brendan Lensink on 2018-05-03.
//  Copyright © 2018 Steamclock. All rights reserved.
//

import RealmSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let newSchemaVersion: UInt64 = 1
        let config = Realm.Configuration(
            schemaVersion: newSchemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < newSchemaVersion {
                    migration.enumerateObjects(ofType: RealmMatch.className()) { _, newObject in
                        newObject!["theirName"] = nil
                    }
                }
        })

        Realm.Configuration.defaultConfiguration = config
        _ = try? Realm()

        return true
    }
}

extension Realm {
    // swiftlint:disable force_try
    static let shared = try! Realm()
}
