//
//  SessionUser.swift
//  HinderApp
//
//  Created by Marshall Briggs on 12/10/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation

class SessionHost {
    
    private static var sharedInstance: SessionHost!
    
    var email: String
    var events: [String]
    var populatedEvents: [Any]
    
    static var hostModel: Dictionary<String, Any>!
    static var setup = false
    
    private init(json: Dictionary<String, Any>) {
        self.email = json["email"] as! String
        self.events = json["events"] as! [String]
        self.populatedEvents = [] as! [Any]
        SessionHost.sharedInstance = self
    }
    
    static func shared() -> SessionHost {
        switch sharedInstance {
        case let instance?:
            return instance
        default:
            sharedInstance = SessionHost(json: hostModel)
            return sharedInstance
        }
    }
    
    static func setupSharedInstance(host: Dictionary<String, Any>) {
        hostModel = host
        setup = true
    }
    
    static func extractModel(user: User) -> Dictionary<String, Any> {
        let resDict = ["email": "dummyHost@hinder.com", "events": [
            "pR8pKgxzw", "pR8pKn8xq", "ZAz8GvJjv"]] as! Dictionary<String, Any>
        return resDict
    }
}

