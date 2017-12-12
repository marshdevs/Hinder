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


class HomeViewController: UIViewController,ListAdapterDataSource {
    
    var sessionUser: User?

    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.white
        return view
    }()
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(HomeViewController.settingsClicked))
        
        let hamburgerMenu = UIBarButtonItem(image:UIImage(named: "hamburger"), style: .plain, target: self, action: #selector(HomeViewController.menuClicked))
        
        navigationItem.leftBarButtonItem = settingsButton
        navigationItem.rightBarButtonItem = hamburgerMenu
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    // When the settings icon is selected
    func settingsClicked() {
//        let jsonSkills = [String : Any]()
//        let jsonUser = ["userId": "abc123", "userName": "Kim", "userOccupation": "Student", "userPhoto": "photo.jpg",
//        "userEvents": ["l1231", "dsfce", "dsc324"], "userSkillset": [String : Any]()] as Dictionary<String, Any>
//        var kimSkills = Skillset(json: jsonSkills)
//        var kimUser = User(json: jsonUser)
        let newViewController = EditProfileViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    // When the menu icon is selected
    func menuClicked() {
        /*let newViewController = HamburgerMenuViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)*/

        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "HamburgerMenuViewController") as! HamburgerMenuViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - IGListAdapterDataSource
extension HomeViewController {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var items: [ListDiffable] = [ListDiffable]();

        //TODO: here we would want Events
        /*
         append to items array: first, events we are attending, 
         next, other events we CAN join.
         
         REQUEST TO DB NEEDED HERE, what events we're attending
        
        Events look like:
        { "eventId": string, "eventName": string, "eventDate": string (stored as ISO-8601 formatted string), "eventLocation": ???, 
          "eventDescription": string, "eventPhoto": string url, "eventThumbnail": string url, "eventProjects": array of string project ids, 
          "eventUsers": array of string userids }
        
        Need some way to grab user's location, if we're querying events by location
         */
        let request = EventRequest()
        let eventArray = request.batchGetEvents(eventIds: SessionUser.shared().events)
        items += eventArray as [ListDiffable]
        print("Dumping items")
        dump(items)

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
