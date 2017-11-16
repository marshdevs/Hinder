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
    
    enum RequestResult {
        case success([Any]), failure(Error)
    }
    
    //Get/Query events request: Synchronous version (maybe switch to Async later)
    /**
     Query all Events to populate CollectionView.
     
     This function is called int the
     HomeViewController to lookup all
     relevant Events and populate the
     HomeView with all Events.
     
     - parameter params: Event identifier
     
     - returns: A instance of resArray containing the User
     */
    static func getEvents(params: String) -> [Event] {
        var resArray = [Event]()
        
        let url = URL(string: root + params)!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let semaphore = DispatchSemaphore(value: 0)
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
                    semaphore.signal()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        return resArray
    }
    
    // Current project schema below is wrong

    /**
     Query Project request.
     
     This function is called any time to
     lookup a Project in the server database
     by a string indentifier.
     
     - parameter params: User identifier
     - parameter user: Project object
     
     - returns: A instance of resArray containing the Project
     */
    static func getProjects(params: String) -> [Project] {
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
    
    // Current user schema below is wrong
    /**
     Query User request.
     
     This function is called any time to 
     lookup a User in the server database 
     by a string indentifier.
     
     - parameter params: User identifier
     - parameter user: User object
     
     - returns: A instance of resArray containing the User
     */
    static func getUsers(params: String) -> [User] {
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
    
    /**
     	Handles user project swipe logic.
     
     	This function is called any time that a swipe is
     	made from either a user or a project and it first
     	checks the nature of the swipe (a right or left)
     	and then searches the data base for an existing
     	represented by a pair matching IDs and returns
      	the result.
     
     	- parameters:
            - approve: swipe direction
            - key: The corresponding ID
            - eventId: The ID to identify the swiper
     
     	- returns: A bool value returned by getMatch function call
     */
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
