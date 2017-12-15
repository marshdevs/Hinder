//
//  NetworkTests.swift
//  HinderApp
//
//  Created by Marshall Briggs on 12/14/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import XCTest
@testable import HinderApp

class NetworkTests: XCTestCase {
    
    let eventRequest = EventRequest()
    let userRequest = UserRequest()
    let projectRequest = ProjectRequest()
    let matchRequest = MatchRequest()
    
    let menuClickedTextDisplayed : String = "Clicked menu"
    let settingsClickedTextDisplayed : String = "Clicked settings"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func goodEventTest() {
        let newEvent = ["eventId": "empty", "name": "lahacks", "date": "11/11/2011", "location": "los_angeles", "description": "ucla hackathon", "photo": "lahacks.png", "thumbnail": "smalllahacks.png", "projects": ["proja", "projb", "projc"], "users": ["user1", "user2", "user3"]] as [String : Any]
        let eventId = eventRequest.createEvent(event: Event(json: newEvent))
        let event = eventRequest.getEvent(eventId: eventId)
        XCTAssertTrue(eventId == event.eventId)
        
        eventRequest.deleteEvent(eventId: eventId)
    }
    
    func badEventTest() {
        let newEvent = ["eventId": "empty"] as [String : Any]
        let eventId = eventRequest.createEvent(event: Event(json: newEvent))
        let event = eventRequest.getEvent(eventId: eventId)
        XCTAssertFalse(eventId == event.eventId)
    }
    
}

