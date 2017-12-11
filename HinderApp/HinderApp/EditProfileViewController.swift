//
//  EditProfileViewController.swift
//  HinderApp
//
//  Created by Kim Svatos on 11/16/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import IGListKit
import Foundation

class EditProfileViewController: UIViewController, ListAdapterDataSource  {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.white
        return view
    }()
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self

        // Do any additional setup after loading the view.
        
        let backItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(EditProfileViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = backItem
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func back(sender: UIBarButtonItem) {
        print("Back button pressed.")
        let updateUserRequest = UserRequest(endpoint: "updateUser/")
        updateUserRequest.updateUser(user: SessionUser.shared())
        self.navigationController?.popViewController(animated: true)
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
extension EditProfileViewController {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        //get a user's Skillset here
        var items: [ListDiffable] = [ListDiffable]();
        var holderArray = [Skillset]()
        holderArray.append((SessionUser.shared().skillset))
        //todo, make this a skillset
        items = holderArray as [ListDiffable]
        return items
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return EditProfileSectionController(); //placeholder to prevent compilation errors rn
    }
    
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}

