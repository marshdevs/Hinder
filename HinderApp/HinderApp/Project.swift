//
//  Project.swift
//  HinderApp
//
//  Created by Kim Svatos on 11/8/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import IGListKit

/**
 Store information for a group project, include the project name, description, group members, etc.
    * `projectId` (String): ID for the given project
    * `eventId` (String): Event that this project was created for
    * `name` (String): Name of the project
    * `desc` (String): Description of the project
    * `size` ([Int]): Number of group members for this project
    * `photo` (String): Photo for the project
    * `skillSet` (Skillset): Desired skillset for the project
    * `users` ([String]): List of users (user IDs) that are part of the project
 */
class Project: NSObject, ListDiffable {
    
    let projectId: String
    let eventId: String
    let name: String
    let desc: String
    let size: [Int]
    let photo: String
    let skillset: Skillset
    let users: [String]

    /**
     Create a Project object based on the data returned by a ProjectRequest method.
     
     - parameter json: Dictionary that maps Project field names to their respective values.
     
     - important: Input parameter 'json' must be formatted with the following key-value entries:
     * "projectId": String
     * "eventId": String
     * "projectName": String
     * "projectDescription": String
     * "projectSize": [Int]
     * "projectPhoto": String (URL)
     * "projectSkillset": Dictionary<String, Bool>
     * "projectUsers": [String] (an array of user IDs)
     
     - returns: Void. On success, correctly initializes all fields for the Project object
     */
    init(json: Dictionary<String, Any>) {
        self.projectId = json["projectId"] as! String
        self.eventId = json["eventId"] as! String
        self.name = json["projectName"] as! String
        self.desc = json["projectDescription"] as! String
        self.size = json["projectSize"] as! [Int]
        self.photo = json["projectPhoto"] as! String
        self.skillset = Skillset(json: json["projectSkillset"] as! Dictionary<String, Bool>)
        self.users = json["projectUsers"] as! [String]
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }

    /**
     Composes Project information in format Dictionary<String, Any>
     
     - important: Return value will be formatted with the following key-value entries.
     * "name": String
     * "eventId": String
     * "description": String
     * "size": [Int]
     * "photo": String
     * "skillset": Skillset
     * "users": [String] (an array of user IDs)

     - returns: A Dictionary<String, Any> that maps the Project field names to their respective values.
     */
    public func toDict() -> Dictionary<String, Any> {
        let resDict = ["projectId": projectId, "name": self.name, "eventId": self.eventId, "description": self.desc, "size": self.size, "photo": self.photo, "skillset": self.skillset.toDict(), "users": self.users] as! Dictionary<String, Any>
        return resDict
    }
    
    public func addUserToProject(userId: String) {
        return
    }
}
