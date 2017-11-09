//
//  Project.swift
//  HinderApp
//
//  Created by Kim Svatos on 11/8/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import IGListKit


class Project: NSObject, ListDiffable {
    let projectId: String
    let manager: User
    let event: Event
    let location: String
    let isOpen: Bool
    
    init(id: String, manager: User, event: Event, location: String) {
        self.projectId = id
        self.manager = manager
        self.event = event
        self.location = location
        self.isOpen = true
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
