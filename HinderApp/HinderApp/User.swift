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
    
    static let emptyUserHandler = ["userId": "empty", "userName": "empty", "userOccupation": "empty", "userEvents": [], "userPhoto": "empty", "userProjects": [], "userSkillset": ["C++": false, "C": false, "Obj-C": false, "Swift": false, "Python": false, "Java": false, "Javascript": false, "Html": false] as Dictionary<String, Any>] as [String : Any]
    
    var userId: String
    var name: String
    var occupation: String
    var photo: String
    var events: [String]
    var projects: [String]
    var skillset: Skillset
    
    init(json: Dictionary<String, Any>) {
        self.userId = json["userId"] as! String
        self.name = json["userName"] as! String
        self.occupation = json["userOccupation"] as! String
        self.photo = json["userPhoto"] as! String
        self.events = json["userEvents"] as! [String]
        self.projects = json["userProjects"] as! [String]
        self.skillset = Skillset(json: json["userSkillset"] as! Dictionary<String, Bool>)
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
    
    public func photoToImg() -> UIImage {
        let url = URL(string: self.photo)
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)
        return image!
    }
    
    public func toDict() -> Dictionary<String, Any> {
        let resDict = ["userId": self.userId, "name": self.name, "occupation": self.occupation, "events": self.events,
                       "projects": self.projects, "photo": self.photo, "skillset": self.skillset.toDict()] as! Dictionary<String, Any>
        return resDict
    }
}
