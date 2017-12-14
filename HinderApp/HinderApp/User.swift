//
//  User.swift
//  HinderApp
//
//  Created by Kim Svatos on 11/8/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import IGListKit

/**
 Store information for a user, such as their name, skillset, events they are attending, etc.
 * `userId` (String): User ID
 * `name` (String): User's full name
 * `occupation` (String): User's occupation (e.g., student, software engineer, etc.)
 * `photo` (String): Photo of the user
 * `events` ([String]): List of events (event IDs) the user is attending
 * `projects` ([String]): List of projects (project IDs) the user is contributing to
 * `skillSet` (Skillset): The user's skillset
 */
class User: NSObject, ListDiffable {
    
    static let emptyUserHandler = ["userId": "empty", "userName": "empty", "userOccupation": "empty", "userEvents": [], "userPhoto": "empty", "userProjects": [], "userSkillset": ["C++": false, "C": false, "Obj-C": false, "Swift": false, "Python": false, "Java": false, "Javascript": false, "Html": false] as Dictionary<String, Any>] as [String : Any]
    
    var userId: String
    var name: String
    var occupation: String
    var photo: String
    var events: [String]
    var projects: [String]
    var skillset: Skillset
    
    // Populated projects, used to get the actual project objects associated with id
    var populatedProjects: [Any]

    /**
     Create a User object based on the data returned by a UserRequest method.
     
     - parameter json: Dictionary that maps User field names to their respective values.
     
     - important: Input parameter 'json' must be formatted with the following key-value entries:
     * "userId": String
     * "userName": String
     * "userOccupation": String
     * "userPhoto": String (URL)
     * "userEvents": [String]
     * "userProjects": [String]
     * "userSkillset": Dictionary<String, Bool>
     
     - returns: Void. On success, correctly initializes all fields for the Project object
     */
    init(json: Dictionary<String, Any>) {
        self.userId = json["userId"] as! String
        self.name = json["userName"] as! String
        self.occupation = json["userOccupation"] as! String
        self.photo = json["userPhoto"] as! String
        self.events = json["userEvents"] as! [String]
        self.projects = json["userProjects"] as! [String]
        self.skillset = Skillset(json: json["userSkillset"] as! Dictionary<String, Bool>)
        self.populatedProjects = [] as! [Any]
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
    
    /**
     Creates a view of type `UIImage` from the URL stored by member field `User.photo`
     
     - important: URL value stored in `User.photo` must be valid
     
     - returns: On success, returns a `UIImage` for the given URL.
    */
    public func photoToImg() -> UIImage {
        let url = URL(string: self.photo)
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)
        return image!
    }

    /**
     Composes User information in format Dictionary<String, Any>
     
     - important: Return value will be formatted with the following key-value entries.
     * "userId": String
     * "name": String
     * "occupation": String
     * "events": [String] (an array of event IDs)
     * "projects": [String] (an array of project IDs)
     * "photo": String (URL)
     * "skillset": Dictionary<String, Any>
     
     - returns: A Dictionary<String, Any> that maps the User field names to their respective values.
     */
    public func toDict() -> Dictionary<String, Any> {
        let resDict = ["userId": self.userId, "name": self.name, "occupation": self.occupation, "events": self.events,
                       "projects": self.projects, "photo": self.photo, "skillset": self.skillset.toDict()] as! Dictionary<String, Any>
        return resDict
    }
}
