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
    
    // Get/Query event request
    static func getEvent(params: String) -> [Event] {
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
                        resArray.append(Event(json: item))
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        return resArray
    }
    
    // Get/query project request
    // Current project schema below is wrong
    static func getProject(params: String) -> [Project] {
        var resArray = [Project]()
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
                        resArray.append(Project(id: item["projectId"] as! String, manager: item["projectManager"] as! User, event: item["projectEvent"] as! Event, location: item["projectLocation"] as! String))
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        return resArray
    }
    
    // Get/query user request
    // Current user schema below is wrong
    static func getUser(params: String) -> [User] {
        var resArray = [User]()
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
                        resArray.append(User(name: item["userName"] as! String, id: item["userId"] as! String, skillset: item["userSkillset"] as! Skillset))
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        return resArray
    }
    
    // Match request
    static func getMatch(params: String) -> Bool {
        var res = Bool()
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
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Bool {
                    res = json
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        return res
    }
}
