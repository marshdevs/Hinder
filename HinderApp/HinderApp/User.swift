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
    let userId: String
    let name: String
    let occupation: String
    let photo: String
    let events: [String]
    let skillset: Skillset
    
    init(json: Dictionary<String, Any>) {
        self.userId = json["userId"] as! String
        self.name = json["userName"] as! String
        self.occupation = json["userOccupation"] as! String
        self.photo = json["userPhoto"] as! String
        self.events = json["userEvents"] as! [String]
        self.skillset = Skillset(json: json["userSkillset"] as! Dictionary<String, Any>)
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
    
    public func toDict() -> Dictionary<String, Any> {
        let resDict = ["userId": self.userId, "name": self.name, "occupation": self.occupation, "events": self.events,
                       "photo": self.photo, "skillset": self.skillset] as! Dictionary<String, Any>
        return resDict
    }
}
