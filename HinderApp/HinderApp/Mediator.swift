//
//  Mediator.swift
//  HinderApp
//
//  Created by Marshall Briggs on 11/13/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation

class Mediator: NSObject {
    
    /**
     A swipe action.
     
     This function takes in swipe parameters
     and queries the database to see if a pair
     of matching User/Project IDs exists.
     
     - parameter approve: Left (false) or right (true) swipe
     - parameter key: The ID to search the database
     - parameter eventId: The corresponding ID of a previous swipe
     
     - returns: A true or false indicating existence of the match
     */
    func swipe(approve: Bool, key: String, eventId: String) -> Bool {
        let direction = approve ? "/right/" : "/left/"
        return Request.getMatch(params: "match/" + eventId + direction + key)
    }
    
    /**
     Function for a swipe executed by a user.
     
     This function is called when a user swipes
     on a project and then queries the database for a match
     and if one exists it adds the user to the project
     group.
     
     - parameter project: The project swiped on
     - parameter user: The user that initiated the swipe
     - parameter approve: Left (false) or right (true) swipe
     
     - returns: A true (user added to group) or false (not a match)
     */
    func userInitSwipe(user: User, project: Project, approve: Bool) -> Bool {
        let key = user.id + "&" + project.projectId
        let eventId = project.event.eventId
        let match = swipe(approve: approve, key: key, eventId: eventId)
        if (match) {
            project.addUserToProject(userId: user.id)
            return true
        }
        return false
    }
    
    /**
     Function for a swipe executed by a project.
     
     This function is called when a project swipes 
     on a user and then queries the database for a match 
     and if one exists it adds the user to the project
     group.
     
     - parameter project: The project that initiated the swipe
     - parameter user: The user swiped on
     - parameter approve: Left (false) or right (true) swipe
     
     - returns: A true (user added to group) or false (not a match)
     */
    func projectInitSwipe(project: Project, user: User, approve: Bool) -> Bool {
        let key = user.id + "&" + project.projectId
        let eventId = project.event.eventId
        let match = swipe(approve: approve, key: key, eventId: eventId)
        if (match) {
            project.addUserToProject(userId: user.id)
            return true
        }
        return false
    }
}
