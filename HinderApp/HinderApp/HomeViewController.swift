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
        // TODO: Go to settings view
        print("Clicked settings")
    }
    
    // When the menu icon is selected
    func menuClicked() {
        // TODO: Go to menu view
        print("Clicked menu")
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
        let eventArray = Request.getEvent(params: "queryEvents/los_angeles")
        items += eventArray as [ListDiffable]

        if items.isEmpty {
            var testIntArray = [Int]()
            testIntArray.append(3)
            testIntArray.append(5)
            testIntArray.append(6)
            testIntArray.append(7)
            testIntArray.append(8)
            testIntArray.append(9)
            testIntArray.append(0)
            testIntArray.append(1)
            testIntArray.append(2)
            testIntArray.append(14)
            items = testIntArray as [ListDiffable]
        }
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
