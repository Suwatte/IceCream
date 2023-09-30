//
//  File.swift
//  
//
//  Created by Soledad on 2021/2/7.
//

import Foundation
import RealmSwift

/// PendingRelationshipsWorker is responsible for temporarily storing relationships when objects recovering from CKRecord
final class PendingRelationshipsWorker<Element: Object> {
        
    var pendingListElementPrimaryKeyValue: [AnyHashable: (String, Object)] = [:]
    
    func addToPendingList(elementPrimaryKeyValue: AnyHashable, propertyName: String, owner: Object) {
        pendingListElementPrimaryKeyValue[elementPrimaryKeyValue] = (propertyName, owner)
    }
    
    func resolvePendingListElements() {
        guard pendingListElementPrimaryKeyValue.count > 0 else {
            // Maybe we could add one log here
            return
        }
        
        Task {
            await runOnActor { realm in
                for (primaryKeyValue, (propName, owner)) in self.pendingListElementPrimaryKeyValue {
                    guard let list = owner.value(forKey: propName) as? List<Element> else { return }
                    if let existListElementObject = realm.object(ofType: Element.self, forPrimaryKey: primaryKeyValue) {
                        try realm.write {
                            list.append(existListElementObject)
                        }
                        self.pendingListElementPrimaryKeyValue[primaryKeyValue] = nil
                    } else {
                        print("Cannot find existing resolving record in Realm")
                    }
                }
            }
        }
    }
    
}
