//
//  Request.swift
//  HinderApp
//
//  Created by Marshall Briggs on 11/13/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation

/**
 Handle requests to backend.
 */
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
        
        let endpoint = "queryEvents/"
        let url = URL(string: root + endpoint + params)!
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

    /**
     Query Projects request.
     
     This function is called any time to
     lookup a list of Projects in the server database
     given a list of string indentifiers.
     
     - parameter projectIds: List of projectIds to return information for
     
     - returns: A instance of resArray containing the Projects
     */
    static func getProjects(projectIds: [String]) -> [Project] {
        var resArray = [Project]()
        
        let requestData: [String: Any] = ["projectIds": projectIds]
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        let endpoint = "batchGetProjects"
        let url = URL(string: root + endpoint)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestJsonData
        
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
                        resArray.append(Project(json: item))
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
     Query User request.
     
     This function is called any time to 
     lookup a list of Users in the server database
     by a list of string indentifiers.
     
     - parameter userIds: List of String userIds
     
     - returns: A instance of resArray containing the Users
     */
    static func getUsers(userIds: [String]) -> [User] {
        var resArray = [User]()
        
        let requestData: [String: Any] = ["userIds": userIds]
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        let endpoint = "batchGetUsers"
        let url = URL(string: root + endpoint)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestJsonData
        
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
                        resArray.append(User(json: item))
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
