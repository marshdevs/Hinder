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
     A swipe action
     
     This function takes in swipe parameters
     and queries the database to see if a pair
     of matching User/Project IDs exists
     
     - Parameter:
     - approve: left or right swipe
     - key: the ID to search the database
     - eventID: the corresponding ID of a previous swipe
     
     - Returns: A true or false indicating existence of the match
     */
    func swipe(approve: Bool, key: String, eventId: String) -> Bool {
        let direction = approve ? "/right/" : "/left/"
        return Request.getMatch(params: "match/" + eventId + direction + key)
    }
    
    /**
     Function for a swipe executed by a user
     
     This function is called when a user swipes
     on a project and then queries the database for a match
     and if one exists it adds the user to the project
     group
     
     - Parameter:
     - Project: The project swiped on
     - User: The user that initiated the swipe
     - Approve: left or right swipe
     
     - Returns: A true or false
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
     Function for a swipe executed by a project
     
     This function is called when a project swipes 
     on a user and then queries the database for a match 
     and if one exists it adds the user to the project
     group
     
     - Parameter:
     - Project: The project that initiated the swipe
     - User: The user swiped on
     - Approve: left or right swipe
     
     - Returns: A true or false
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
