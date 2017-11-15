//

/*  Events look like:
 { "eventId": string, "eventName": string, "eventDate": string (stored as ISO-8601 formatted string), "eventLocation": ???,
 "eventDescription": string, "eventPhoto": string url, "eventThumbnail": string url, "eventProjects": array of string project ids,
 "eventUsers": array of string userids }*/

import UIKit
import Foundation
import IGListKit

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
}
