//
//  Mediator.swift
//  HinderApp
//
//  Created by Marshall Briggs on 11/13/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation

class Mediator: NSObject {
    
    func swipe(approve: Bool, key: String, eventId: String) -> Bool {
        let direction = approve ? "/right/" : "/left/"
        return Request.getMatch(params: "match/" + eventId + direction + key)
    }
    
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
