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
    
    override init() {
        super.init()
    }
    
    /**
     Send request to create a new `User` object
     
     - parameter user: `User` object to be created in backend
     
     - returns: void, async
     */
    func createUser(user: User) -> String {
        var res: String?
        
        let requestData: [String: Any] = user.toDict()
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.endpoint = "createUser/"
        self.url = URL(string: super.root + self.endpoint)!
        self.request = URLRequest(url: self.url)
        self.request.httpMethod = "POST"
        self.request.httpBody = requestJsonData
        self.request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let task = self.session.dataTask(with: self.request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                self.semaphore.signal()
                return
            }
            guard let data = data else {
                self.semaphore.signal()
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    res = json["userId"] as! String
                }
                self.semaphore.signal()
            } catch let error {
                print(error.localizedDescription)
                self.semaphore.signal()
            }
        })
        task.resume()
        _ = self.semaphore.wait(timeout: .distantFuture)
        return res!
    }
    
    /**
     Retrieve an existing `User`
     
     - parameter userId: User identifier
     
     - returns: If found, the requested `User` object with identifier `userId`. Otherwise, void.
     */
    func getUser(userId: String) -> User {
        var res = User(json: User.emptyUserHandler)
        
        self.endpoint = "getUser?userId="
        self.url = URL(string: super.root + self.endpoint + userId)!
        self.request = URLRequest(url: self.url)
        let task = self.session.dataTask(with: self.request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                self.semaphore.signal()
                return
            }
            guard let data = data else {
                self.semaphore.signal()
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    if var _ = json["status"] {
                    } else {
                        res = User(json: json)
                    }
                }
                self.semaphore.signal()
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
     Batched get users request.
     
     This function is called any time to
     lookup a list of users in the server database
     by a list of string indentifiers.
     
     - parameter userIds: List of String userIds
     
     - returns: A instance of resArray containing the users
     */
    func batchGetUsers(userIds: [String]) -> [User] {
        var resArray = [User]()
        
        let requestData: [String: Any] = ["userIds": userIds]
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.endpoint = "batchGetUsers/"
        self.url = URL(string: super.root + self.endpoint)!
        self.request = URLRequest(url: self.url)
        self.request.httpMethod = "POST"
        self.request.httpBody = requestJsonData
        self.request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let task = self.session.dataTask(with: self.request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                self.semaphore.signal()
                return
            }
            guard let data = data else {
                self.semaphore.signal()
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                    for item in json {
                        resArray.append(User(json: item))
                    }
                }
                self.semaphore.signal()
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
     Update fields of an existing `User`
     
     - parameter user: The `User` object to be updated
     
     - returns: void, async
     */
    func updateUser(user: User) {
        let requestData: [String: Any] = user.toDict()
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.endpoint = "updateUser/"
        self.url = URL(string: super.root + self.endpoint)!
        self.request = URLRequest(url: self.url)
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
     Delete a `User`
     
     - parameter userId: `User` identifier
     
     - returns: void, async
     */
    func deleteUser(userId: String) {
        let requestData: [String: Any] = ["userId": userId]
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.endpoint = "deleteUser/"
        self.url = URL(string: super.root + self.endpoint)!
        self.request = URLRequest(url: self.url)
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
    
    /**
     Get the `userId` for a particular email
     
     - parameter email: email address from Facebook
     
     - returns: The requested `userId`
     */
    func getId(email: String) -> String {
        var res: String?
        
        self.endpoint = "getId?email="
        self.url = URL(string: super.root + self.endpoint + email)!
        self.request = URLRequest(url: self.url)
        let task = self.session.dataTask(with: self.request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                self.semaphore.signal()
                return
            }
            guard let data = data else {
                self.semaphore.signal()
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    res = json["userId"] as! String
                }
                self.semaphore.signal()
            } catch let error {
                print(error.localizedDescription)
                self.semaphore.signal()
            }
        })
        task.resume()
        _ = self.semaphore.wait(timeout: .distantFuture)
        return res!
    }
}
