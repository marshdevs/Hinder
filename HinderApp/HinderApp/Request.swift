//
//  Request.swift
//  HinderApp
//
//  Created by Marshall Briggs on 11/13/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation

class Request {
    static let root = "http://ec2-184-72-191-21.compute-1.amazonaws.com:8080/"
    // Returns an array of responses
    
    // Event request
    static func get(type: Event, params: String) -> [Event] {
        var resArray = [Event]()
        
        let url = URL(string: root + params)!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                    for item in json {
                        // TO DO: be able to access event data to actually initialize new Event object
                        resArray.append(Event(name: item["eventName"] as! String, location: item["eventLocation"] as! String))
                    }
                    resArray.append(Event(name: "TestName", location:"UCLA"))
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        return resArray
    }
    
    // Project request
    static func get(type: Project, params: String) -> [Project] {
        var resArray = [Project]()
        //TODO
        return resArray
    }
    
    // User request
    static func get(type: User, params: String) -> [User] {
        var resArray = [User]()
        //TODO
        return resArray
    }
    
    // Match request
    static func get(params: String) -> Bool {
        var res = true
        return res
    }
}
