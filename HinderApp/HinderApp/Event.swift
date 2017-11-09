//

/*Events look like:
{ "eventId": "", "name": "", "date": "", "location": "", "description": "", "photo": "", "thumbnail": "",
    "projects": [], "users": [] }
*/

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
    //projects is list of project ids?
    let projects: [String]
    //users is a list of UserID
    let users: [String]
    //TODO check if that is in fact how you would declare the type as an array of that type
    
    
    init(name: String, location: String) {
        self.eventId = ""
        self.name = name
        self.date = Date()
        self.location = location
        self.desc = ""
        self.photo = URL(fileURLWithPath: "")
        self.thumbnail = URL(fileURLWithPath: "")
        self.projects = [String]()
        self.users = [String]()
    }
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
