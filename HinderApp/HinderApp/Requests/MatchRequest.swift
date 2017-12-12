//
//  MatchRequest.swift
//  HinderApp
//
//  Created by Marshall Briggs on 12/4/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation

/**
 Handle Match requests to backend.
 */
class MatchRequest: Request {
    
    override init() {
        super.init()
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
    func getMatch(params: String) -> Bool {
        var res = Bool()
        
        self.endpoint = "match/"
        self.url = URL(string: super.root + super.endpoint + params)!
        self.request = URLRequest(url: self.url)
        let task = self.session.dataTask(with: self.request as URLRequest, completionHandler: { data, response, error in
            
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
    
}
