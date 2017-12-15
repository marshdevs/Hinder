//
//  ProfileUserInfoSectionController.swift
//  HinderApp
//
//  Created by Kim Svatos on 12/14/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import IGListKit

/*
 FeedSectionController, will controll our views that use a feed,
 like events, groups, etc
 */

import UIKit
import IGListKit


class ProfileUserInfoSectionController: ListSectionController, UITextViewDelegate {
    
    var user: User!
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        SessionUser.shared().occupation = textView.text
        // print(textView.text); //the textView parameter is the textView where text was changed
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        return CGSize(width: context.containerSize.width, height: 200)
    
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        // TODO: if first section, add "My Events" header
        let cellClass: AnyClass = ProfileUserInfoCell.self
        let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)
        
        if let cell = cell as? ProfileUserInfoCell {
            //do shit here
            cell.delegate = self
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
        // message = object as? Message
    }
}

