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
    let date: Date
    let location: String
    let desc: String
    let photo: URL
    let thumbnail: URL
    let projects: [String]
    let users: [String]

    init(json: Dictionary<String, Any>) {
        self.eventId = json["eventId"] as! String
        self.name = json["eventName"] as! String
        self.date = json["eventDate"] as! Date
        self.location = json["eventLocation"] as! String
        self.desc = json["eventDescription"] as! String
        self.photo = json["eventPhoto"] as! URL
        self.thumbnail = json["eventThumbnail"] as! URL
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
