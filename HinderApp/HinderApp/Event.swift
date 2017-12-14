import UIKit
import Foundation
import IGListKit


/**
  Stores information for an event (hackathon, class, etc.) such as event name, location, date, etc.
    * `eventId` (String): ID for the given event
    * `name` (String): Name for the given event
    * `date` (String): Date of the event
    * `location` (String): Location of the event
    * `desc` (String): Event description
    * `photo` (String): Photo for the event
    * `thumbnail` (String): Thumbnail icon for the event
    * `projects` ([String]): List of projects (project IDs) created for the event
    * `users` ([String]): List of users (user IDs) attending the event
 */
class Event: NSObject, ListDiffable {
    
    let eventId: String
    let name: String
    let date: String
    let location: String
    let desc: String
    let photo: String
    let thumbnail: String
    let projects: [String]
    let users: [String]

    /**
     Create an Event object based on the data returned by an EventRequest method.
     
     - parameter json: Dictionary that maps Event field names to their respective values.
     
     - important: Input parameter 'json' must be formatted with the following key-value entries:
        * "eventId": String
        * "eventName": String
        * "eventDate": String (stored as ISO-8601 formatted string)
        * "eventLocation": String
        * "eventDescription": String
        * "eventPhoto": String (URL)
        * "eventThumbnail": String (URL)
        * "eventProjects": [String] (an array of project IDs)
        * "eventUsers": [String] (an array of user IDs)
     
     - returns: Void. On success, correctly initializes all fields for the Event object
    */
    init(json: Dictionary<String, Any>) {
        self.eventId = json["eventId"] as! String
        self.name = json["eventName"] as! String
        // date type should be Date
        self.date = json["eventDate"] as! String
        self.location = json["eventLocation"] as! String
        self.desc = json["eventDescription"] as! String
        // photo type should be URL
        self.photo = json["eventPhoto"] as! String
        // thumbnail type should be URL
        self.thumbnail = json["eventThumbnail"] as! String
        self.projects = json["eventProjects"] as! [String]
        self.users = json["eventUsers"] as! [String]
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
    
    /**
     Composes Event information in format Dictionary<String, Any>
     
     - important: Return value will be formatted with the following key-value entries.
         * "eventId": String
         * "eventName": String
         * "eventDate": String (stored as ISO-8601 formatted string)
         * "eventLocation": String
         * "eventDescription": String
         * "eventPhoto": String (URL)
         * "eventThumbnail": String (URL)
         * "eventProjects": [String] (an array of project IDs)
         * "eventUsers": [String] (an array of user IDs)
     
     - returns: A Dictionary<String, Any> that maps the Event field names to their respective values.
    */
    public func toDict() -> Dictionary<String, Any> {
        let resDict = ["eventId": self.eventId, "name": self.name, "date": self.date, "location": self.location, "description": self.desc,
                       "photo": self.photo, "thumbnail": self.thumbnail, "projects": self.projects, "users": self.users] as Dictionary<String, Any>
        return resDict
    }
}
