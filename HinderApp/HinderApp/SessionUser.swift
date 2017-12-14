//
//  SessionUser.swift
//  HinderApp
//
//  Created by Marshall Briggs on 12/10/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation

/**
 Singleton object that represents the current logged-in User.
 * `sharedInstance` (SessionUser): The single, shared, globally accessible instance of `SessionUser`
 * `userModel` (User): The User that the `SessionUser` represents
 * `setup` (Bool): Indicates whether `sharedInstance` has already been set up
 */
class SessionUser: User {
    
    private static var sharedInstance: SessionUser!
    
    static var userModel: User!
    static var setup = false
    
    /**
     Create a Singleton object that represents the given User.
     
     - parameter user: The User object to be represented by `SessionUser`
     */
    private init(user: User) {
        super.init(json: SessionUser.extractModel(user: user))
        SessionUser.sharedInstance = self
    }
    
    /**
     Accessor method for the single `SessionUser` instance. Returns the instance if it already exists, or creates the instance.
    */
    static func shared() -> SessionUser {
        switch sharedInstance {
        case let instance?:
            return instance
        default:
            sharedInstance = SessionUser(user: userModel)
            return sharedInstance
        }
    }
    
    /**
     Setup method for creating the `SessionUser` instance.
     
     - parameter user: The User object to be represented by `SessionUser`
    */
    static func setupSharedInstance(user: User) {
        userModel = user
        setup = true
    }
    
    /**
     Parses information of a User object into a Dictionary.

     - important: Return value will be formatted with the following key-value entries.
     * "userId": String
     * "userName": String
     * "userOccupation": String
     * "userEvents": [String] (an array of event IDs)
     * "userProjects": [String] (an array of project IDs)
     * "userPhoto": String (URL)
     * "userSkillset": Dictionary<String, Any>
     
     - parameter user: The User object that information will be parsed from
     
     - returns: A Dictionary<String, Any> that maps the User field names to their respective values.
    */
    static func extractModel(user: User) -> Dictionary<String, Any> {
        let resDict = ["userId": user.userId, "userName": user.name, "userOccupation": user.occupation, "userEvents": user.events,
                       "userProjects": user.projects, "userPhoto": user.photo, "userSkillset": user.skillset.toDict()] as! Dictionary<String, Any>
        return resDict
    }
}
