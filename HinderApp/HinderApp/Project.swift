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
    let eventId: String
    let name: String
    let desc: String
    let size: [Int]
    let photo: String
    let skillset: Skillset
    let users: [String]
    
    init(json: Dictionary<String, Any>) {
        self.projectId = json["projectId"] as! String
        self.eventId = json["eventId"] as! String
        self.name = json["projectName"] as! String
        self.desc = json["projectDescription"] as! String
        self.size = json["projectSize"] as! [Int]
        self.photo = json["projectPhoto"] as! String
        self.skillset = Skillset(json: json["projectSkillset"] as! Dictionary<String, Any>)
        self.users = json["projectUsers"] as! [String]
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
    
    public func addUserToProject(userId: String) {
        return
    }
}
