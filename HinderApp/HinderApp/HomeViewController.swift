//
//  ViewController.swift
//  HinderApp
//
//  Created by Kim Svatos on 11/3/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import IGListKit
import Foundation
//import URLSession

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - IGListAdapterDataSource
extension HomeViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var items: [ListDiffable] = [ListDiffable]();
        //TODO: here we would want Events
        /*
         append to items array: first, events we are attending, 
         next, other events we CAN join.
         
         REQUEST TO DB NEEDED HERE, what events we're attending
        
        Events look like:
        { "eventId": string, "name": string, "date": string (stored as ISO-8601 formatted string), "location": ???, 
          "description": string, "photo": string url, "thumbnail": string url, "projects": array of string project ids, 
          "users": array of string userids }
        
        Need some way to grab user's location, if we're querying events by location
         */
        
        let url = URL(string: "http://ec2-184-72-191-21.compute-1.amazonaws.com:8080/queryEvents/<userLocation>")!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        
            guard error == nil else {
                return
            }                                                                    
            guard let data = data else {
                return
            }                                                                     
            do {
                var eventArray = [Event]()
                for event in data {
                    eventArray.append(Event(name: "TestName", location:"UCLA"))
                    // TO DO: be able to access event data to actually initialize new Event object
                    //items += event as [IGListDiffable]
                    //items.append(event)
                }
                items += eventArray as [ListDiffable]
            }
        })
        task.resume()
                
        return items
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        /*if object is TypeofObject {
            return thatKindOfSectionController()
        }
         else if object is TypeOfObject {....
         TODO:
        }*/
        return FeedSectionController(); //placeholder to prevent compilation errors rn
    }
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
