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
    
    override init(endpoint: String) {
        super.init(endpoint: endpoint)
    }
    
    /**
     Create an Event
     
     - parameter event: Event object
     
     - returns: void, async
     */
    func createEvent(event: Event) {
        let requestData: [String: Any] = event.toDict()
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
     Get a single Event
     
     - parameter eventId: Event identifier

     - returns: The requested event object
     */
    func getEvent(eventId: String) -> Event {
        var res = Event(json: self.emptyEventHandler)
        
        self.url = URL(string: super.root + self.endpoint + eventId)!
        self.request = URLRequest(url: self.url)
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
                        res = (Event(json: item))
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
    func queryEvents(params: String) -> [Event] {
        var resArray = [Event]()
        
        self.url = URL(string: super.root + self.endpoint + params)!
        self.request = URLRequest(url: self.url)
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
                        resArray.append(Event(json: item))
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
     Batch get Events request.
     
     This function is called any time to
     lookup a list of Events in the server database
     given a list of string indentifiers.
     
     - parameter eventIds: List of eventIds to return information for
     
     - returns: A instance of resArray containing the Events
     */
    func batchGetEvents(eventIds: [String]) -> [Event] {
        var resArray = [Event]()
        
        let requestData = ["eventIds": eventIds]
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
                        resArray.append(Event(json: item))
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
     Update fields of an Event
     
     - parameter event: Updated event object
     
     - returns: void, async
     */
    func updateEvent(event: Event) {
        let requestData: [String: Any] = event.toDict()
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
     Delete an event
     
     - parameter eventId: Event identifier
     
     - returns: void, async
     */
    func deleteEvent(eventId: String) {
        let requestData: [String: Any] = ["eventId": eventId]
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
