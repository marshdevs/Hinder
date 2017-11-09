//
//  User.swift
//  HinderApp
//
//  Created by Kim Svatos on 11/8/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import IGListKit

class User: NSObject, ListDiffable {
    let name: String
    let id: String
    let skillset: Skillset
    
    init(name: String, id: String, skillset: Skillset) {
        self.name = name
        self.id = id
        self.skillset = skillset
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
