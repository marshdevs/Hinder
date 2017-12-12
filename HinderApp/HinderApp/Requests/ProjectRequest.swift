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
    
    let emptyProjectHandler = ["projectName": "empty", "eventId": "empty", "projectDescription": "If you're seeing this, something went wrong.", "projectSize": [1, 1], "projectPhoto": "empty", "projectSkillset": ["empty": true] as Dictionary<String, Any>, "projectUsers": []] as [String : Any]
    
    override init() {
        super.init()
    }

    /**
     Create a Project
     
     - parameter project: Project object
     
     - returns: void, async
     */
    func createProject(project: Project) {
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
     Get a single Project
     
     - parameter projectId: Project identifier
     
     - returns: The requested Project object
     */
    func getProject(projectId: String) -> Project {
        var res = Project(json: self.emptyProjectHandler)
        
        self.endpoint = "getProject?projectId="
        self.url = URL(string: super.root + self.endpoint + projectId)!
        self.request = URLRequest(url: self.url)
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
                        // TO DO: be able to access event data to actually initialize new Event object
                        res = (Project(json: item))
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
        return res
    }
    
    /**
     Get Projects request.
     
     This function is called any time to
     lookup a list of Projects in the server database
     given a list of string indentifiers.
     
     - parameter projectIds: List of projectIds to return information for
     
     - returns: A instance of resArray containing the Projects
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
     Update a Project
     
     - parameter project: The updated Project object
     
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
     Delete a Project
     
     - parameter projectId: Project identifier
     
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
