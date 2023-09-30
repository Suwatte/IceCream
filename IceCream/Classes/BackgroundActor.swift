//
//  BackgroundActor.swift
//
//
//  Created by Mantton on 2023-09-30.
//

import Foundation
import RealmSwift

@globalActor actor BackgroundRealmActor: GlobalActor {
    static var shared = BackgroundRealmActor()
}

@BackgroundRealmActor
func runOnActor(_ action: @escaping (Realm) throws -> Void) async {
    do {
        let realm = try await Realm(actor: BackgroundRealmActor.shared)
        try action(realm)
    } catch {
        print(error)
    }

}

