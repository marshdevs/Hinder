//
//  EventPageViewController.swift
//  HinderApp
//
//  Created by Kim Svatos on 11/13/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import IGListKit

class EventPageViewController: UIViewController, ListAdapterDataSource {

    var event: Event;
    
    public func setEvent(myEvent: Event) {
        event = myEvent;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - IGListAdapterDataSource
extension EventPageViewController {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var items: [ListDiffable] = [ListDiffable]();
        var eventArray = [Event]()
        eventArray.append(event)
        items = eventArray as [ListDiffable]
        return items
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return FeedSectionController(event: object as! Event); //placeholder to prevent compilation errors rn
    }
    
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
