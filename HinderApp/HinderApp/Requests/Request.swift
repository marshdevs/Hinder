//
//  Request.swift
//  HinderApp
//
//  Created by Marshall Briggs on 11/13/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation

/**
 Handle requests (e.g, EventRequest, ProjectRequest, UserRequest, MatchRequest) to backend.
 */
class Request {
    var url: URL
    var request: URLRequest
    var endpoint: String
    let root = "http://ec2-184-72-191-21.compute-1.amazonaws.com:8080/"
//    let root = "http://localhost:8080/"
    let session: URLSession
    let semaphore: DispatchSemaphore
    
    /**
    Initialze the URL request to backend.
    
    - returns: Void.
    */
    init() {
        self.endpoint = ""
        self.url = URL(string: root + endpoint)!
        self.request = URLRequest(url: url)
        self.session = URLSession.shared
        self.semaphore = DispatchSemaphore(value: 0)
    }
    
    /**
     Gives an `Error` in the event that a request fails.
    */
    enum RequestResult {
        case success([Any]), failure(Error)
    }

}
