//
//  Mediator.swift
//  HinderApp
//
//  Created by Marshall Briggs on 11/13/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation

class Mediator: NSObject {
    
    func swipe(approve: Bool, key: String) -> Bool {
        let direction = approve ? "right/" : "left/"
        return Request.get(params: "match/" + direction + key)
    }
    
    func userInitSwipe(user: User, project: Project, approve: Bool) -> Bool {
        let key = user.id + "&" + project.projectId
        return swipe(approve: approve, key: key)
        // add user to project
    }
    
    func projectInitSwipe(project: Project, user: User, approve: Bool) -> Bool {
        let key = user.id + "&" + project.projectId
        return swipe(approve: approve, key: key)
        // add user to project
    }
}
