//
//  ProjectRequest.swift
//  HinderApp
//
//  Created by Marshall Briggs on 12/4/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation

/**
 Handle Project requests to backend.
 */
class ProjectRequest: Request {
    
    let emptyProjectHandler = ["projectId": "empty", "projectName": "empty", "eventId": "empty", "projectDescription": "empty", "projectSize": [1, 1], "projectPhoto": "empty", "projectSkillset": ["C++": true, "C": true, "Html": true, "Java": true, "Javascript": true, "Obj-C": true, "Python": true, "Swift": true] as Dictionary<String, Any>, "projectUsers": []] as [String : Any]
    
    override init() {
        super.init()
    }

    /**
     Send a request to create a new `Project`.
     
     - parameter project: `Project` object to be created in backend
     
     - returns: void, async
     */
    func createProject(project: Project) -> String {
        var res: String?
        
        let requestData: [String: Any] = project.toDict()
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.endpoint = "createProject/"
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
                    res = json["projectId"] as! String
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
     Retrieve an existing `Project`
     
     - parameter projectId: Project identifier
     
     - returns: If found, the requested `Project` object with identifier `projectId`. Otherwise, void.
     */
    func getProject(projectId: String) -> Project {
        var res = Project(json: self.emptyProjectHandler)
        
        self.endpoint = "getProject?projectId="
        self.url = URL(string: super.root + self.endpoint + projectId)!
        self.request = URLRequest(url: self.url)
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
                    if var _ = json["status"] {
                    } else {
                        res = Project(json: json)
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
     Get projects request.
     
     This function is called any time to
     lookup a list of projects in the server database
     given a list of string indentifiers.
     
     - parameter projectIds: List of projectIds to return information for
     
     - returns: A instance of resArray containing the projects
     */
    func batchGetProjects(projectIds: [String]) -> [Project] {
        var resArray = [Project]()
        
        self.endpoint = "batchGetProjects/"
        self.url = URL(string: super.root + self.endpoint)!
        self.request = URLRequest(url: self.url)
        let requestData: [String: Any] = ["projectIds": projectIds]
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
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
                        resArray.append(Project(json: item))
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
     Update fields of an existing `Project`
     
     - parameter project: The `Project` object to be updated
     
     - returns: void, async
     */
    func updateProject(project: Project) {
        let requestData: [String: Any] = project.toDict()
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.endpoint = "updateProject/"
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
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
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
     Delete a `Project`
     
     - parameter projectId: `Project` identifier
     
     - returns: void, async
     */
    func deleteProject(projectId: String) {
        let requestData: [String: Any] = ["projectId": projectId]
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.endpoint = "deleteProject/"
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
    
    
}
