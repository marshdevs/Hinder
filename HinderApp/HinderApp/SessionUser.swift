//
//  SessionUser.swift
//  HinderApp
//
//  Created by Marshall Briggs on 12/10/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation

class SessionUser: User {
    
    private static var sharedInstance: SessionUser!
    
    static var userModel: User!
    static var setup = false
    
    private init(user: User) {
        super.init(json: SessionUser.extractModel(user: user))
        SessionUser.sharedInstance = self
    }
    
    static func shared() -> SessionUser {
        switch sharedInstance {
        case let instance?:
            return instance
        default:
            sharedInstance = SessionUser(user: userModel)
            return sharedInstance
        }
    }
    
    static func setupSharedInstance(user: User) {
        userModel = user
        setup = true
    }
    
    static func extractModel(user: User) -> Dictionary<String, Any> {
        let resDict = ["userId": user.userId, "userName": user.name, "userOccupation": user.occupation, "userEvents": user.events,
                       "userProjects": user.projects, "userPhoto": user.photo, "userSkillset": user.skillset.toDict()] as! Dictionary<String, Any>
        return resDict
    }
}
