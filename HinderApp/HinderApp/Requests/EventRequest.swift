//
//  EventRequest.swift
//  HinderApp
//
//  Created by Marshall Briggs on 12/4/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation

/**
 Handle Event requests to backend.
 */
class EventRequest: Request {
    
    let emptyEventHandler = ["eventName": "empty", "eventDate": "00/00/0000", "eventLocation": "empty", "eventDescription": "If you're seeing this, something went wrong.", "eventPhoto": "empty", "eventThumbnail": "empty", "eventProjects": ["a", "b", "c"], "eventUsers": ["a", "b", "c"]] as [String : Any]
    
    override init() {
        super.init()
    }
    
    /**
     Send a request to create a new `Event`.
     
     - parameter event: Event object to be created in backend.
     
     - returns: void, async
     */
    func createEvent(event: Event) -> String {
        var res: String?
        
        let requestData: [String: Any] = event.toDict()
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.endpoint = "createEvent/"
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
                    res = json["eventId"] as! String
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
     Retrieve an existing Event.
     
     - parameter eventId: Event identifier

     - returns: If found, the requested `Event` object with identifier `eventId`. Otherwise, void.
     */
    func getEvent(eventId: String) -> Event {
        var res = Event(json: self.emptyEventHandler)
        
        self.endpoint = "getEvent?eventId="
        self.url = URL(string: super.root + self.endpoint + eventId)!
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
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                    for item in json {
                        // TO DO: be able to access event data to actually initialize new Event object
                        res = (Event(json: item))
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
    
    //Get/Query events request: Synchronous version (maybe switch to Async later)
    /**
     Query all existing events to populate a CollectionView.
     
     This function is called in the
     HomeViewController to lookup all
     relevant events and populate the
     HomeView with all events.
     
     - parameter params: Event identifier
     
     - returns: A instance of resArray containing the list of events
     */
    func queryEvents(params: String) -> [Event] {
        var resArray = [Event]()
        
        self.endpoint = "queryEvents/"
        self.url = URL(string: super.root + self.endpoint + params)!
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
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                    for item in json {
                        // TO DO: be able to access event data to actually initialize new Event object
                        resArray.append(Event(json: item))
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
     Batch get events request.
     
     This function is called any time to
     lookup a list of events in the server database
     given a list of string indentifiers.
     
     - parameter eventIds: List of event identifiers (`eventId`) to return information for
     
     - returns: A instance of resArray containing the events retrieved
     */
    func batchGetEvents(eventIds: [String]) -> [Event] {
        var resArray = [Event]()
        
        let requestData = ["eventIds": eventIds]
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.endpoint = "batchGetEvents/"
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
                        resArray.append(Event(json: item))
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
     Update fields of an existing `Event`
     
     - parameter event: The `Event` object to be updated
     
     - returns: void, async
     */
    func updateEvent(event: Event) {
        let requestData: [String: Any] = event.toDict()
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.endpoint = "updateEvent/"
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
     Delete an `Event`
     
     - parameter eventId: `Event` identifier
     
     - returns: void, async
     */
    func deleteEvent(eventId: String) {
        let requestData: [String: Any] = ["eventId": eventId]
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.endpoint = "deleteEvent/"
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
     Authenticate host email and password, or create a new entry
     
     - parameter email: Host email address
     - parameter password: Host provided password
     
     - returns: JSON object
     */
    func authenticateHost(email: String, password: String) -> Dictionary<String, Any> {
        var res: Dictionary<String, Any>?
        
        let requestData: [String: Any] = ["email": email, "password": password]
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.endpoint = "authenticateHost/"
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
                    print(json)
                    res = json
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
     Get host events
     
     - parameter email: Host email address
     
     - returns: JSON object
     */
    func getHostEvents(email: String) -> Dictionary<String, Any> {
        var res: Dictionary<String, Any>?
        
        self.endpoint = "getHostEvents?email=" + email
        self.url = URL(string: super.root + self.endpoint)!
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
                    print(json)
                    res = json
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
     Update the host's event list
     
     - parameter email: host email
     - parameter events: Updated event list [String]
     
     - returns: void, async
     */
    func updateHost(email: String, events: [String]) {
        let requestData: [String: Any] = ["email": email, "events": events]
        let requestJsonData = try? JSONSerialization.data(withJSONObject: requestData)
        
        self.endpoint = "updateHost/"
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
}

