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
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
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

        let url = URL(string: "http://ec2-184-72-191-21.compute-1.amazonaws.com:8080/queryEvents/los_angeles")!
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
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
                    var eventArray = [Event]()
                    for event in json {
                        eventArray.append(Event(json: event))
                    }
                    items += eventArray as [ListDiffable]
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
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
