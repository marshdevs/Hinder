//
//  UserRequest.swift
//  HinderApp
//
//  Created by Marshall Briggs on 12/4/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation

/**
 Handle User requests to backend.
 */
class UserRequest: Request {
    
    let emptyUserHandler = ["userId": "empty", "userName": "empty", "userOccupation": "empty", "userEvents": ["a", "b", "c"], "userPhoto": "empty", "userSkillset": ["C++": false, "C": false, "Obj-C": false, "Swift": false, "Python": false, "Java": false, "Javascript": false, "Html": false] as Dictionary<String, Any>] as [String : Any]
    
    override init(endpoint: String) {
        super.init(endpoint: endpoint)
    }
    
    /**
     Create a User
     
     - parameter user: User object
     
     - returns: void, async
     */
    func createUser(user: User) {
        let requestData: [String: Any] = user.toDict()
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.request.httpMethod = "POST"
        self.request.httpBody = requestJsonData
        self.request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let task = self.session.dataTask(with: self.request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                    for item in json {
                        dump(item)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    /**
     Get a single User
     
     - parameter userId: User identifier
     
     - returns: The requested User object
     */
    func getUser(userId: String) -> User {
        print("Received a getUser request...")
        var res = User(json: self.emptyUserHandler)
        
        self.url = URL(string: super.root + self.endpoint + userId)!
        self.request = URLRequest(url: self.url)
        let task = self.session.dataTask(with: self.request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    res = User(json: json)
                    self.semaphore.signal()
                }
            } catch let error {
                print(error.localizedDescription)
                self.semaphore.signal()
            }
        })
        task.resume()
        _ = self.semaphore.wait(timeout: .distantFuture)
        return res
    }
    
    /**
     Batched get Users request.
     
     This function is called any time to
     lookup a list of Users in the server database
     by a list of string indentifiers.
     
     - parameter userIds: List of String userIds
     
     - returns: A instance of resArray containing the Users
     */
    func batchGetUsers(userIds: [String]) -> [User] {
        var resArray = [User]()
        
        let requestData: [String: Any] = ["userIds": userIds]
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.request.httpMethod = "POST"
        self.request.httpBody = requestJsonData
        self.request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let task = self.session.dataTask(with: self.request as URLRequest, completionHandler: { data, response, error in
            
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
                    self.semaphore.signal()
                }
            } catch let error {
                print(error.localizedDescription)
                self.semaphore.signal()
            }
        })
        task.resume()
        _ = self.semaphore.wait(timeout: .distantFuture)
        return resArray
    }
    
    /**
     Update a User
     
     - parameter user: The updated User object
     
     - returns: void, async
     */
    func updateUser(user: User) {
        let requestData: [String: Any] = user.toDict()
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.request.httpMethod = "PUT"
        self.request.httpBody = requestJsonData
        self.request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let task = self.session.dataTask(with: self.request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                    for item in json {
                        dump(item)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    /**
     Delete a User
     
     - parameter userId: User identifier
     
     - returns: void, async
     */
    func deleteUser(userId: String) {
        let requestData: [String: Any] = ["userId": userId]
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.request.httpMethod = "DELETE"
        self.request.httpBody = requestJsonData
        self.request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let task = self.session.dataTask(with: self.request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                    for item in json {
                        dump(item)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
}
