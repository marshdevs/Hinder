//
//  EditProfileSectionController.swift
//  HinderApp
//
//  Created by Kim Svatos on 11/16/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import IGListKit

protocol editDelegate: class {
    func didFinishTask(sender: SkillSetEditCell, turnedOn: Bool)
}

class EditProfileSectionController: ListSectionController, editDelegate {
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
    
    func didFinishTask(sender: SkillSetEditCell, turnedOn: Bool) {
        // turnedOn bool will indicate TRUE if we need to newly
        // save as true, FALSE if we need to newly save FALSE
        let text = sender.label.text
        if text == "C++" {
            print(SessionUser.shared().skillset.arraySkills[0])
            print(turnedOn)
            SessionUser.shared().skillset.arraySkills[0] = turnedOn
        } else if text == "C" {
            SessionUser.shared().skillset.arraySkills[1] = turnedOn
        } else if text == "Obj-C" {
            SessionUser.shared().skillset.arraySkills[2] = turnedOn
        }else if text == "Swift" {
            SessionUser.shared().skillset.arraySkills[3] = turnedOn
        }else if text == "Python" {
            SessionUser.shared().skillset.arraySkills[4] = turnedOn
        }else if text == "Java" {
            SessionUser.shared().skillset.arraySkills[5] = turnedOn
        }else if text == "Javascript" {
            SessionUser.shared().skillset.arraySkills[6] = turnedOn
        }else if text == "Html" {
            SessionUser.shared().skillset.arraySkills[7] = turnedOn
        }
    }
    override func numberOfItems() -> Int {
        if self.section == 0 {
            return 1
        } else {
            return 8
        }
       // return 8
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        if self.section == 0 {
            return CGSize(width: context.containerSize.width, height: 250)
        }
        else {
            return CGSize(width: context.containerSize.width, height: ToggleHeight)
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        // TODO: if first section, add "My Events" header
        let cellClass: AnyClass = self.section == 0 ? ProfileUserInfoCell.self : SkillSetEditCell.self
        
        
        let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)
        if let cell = cell as? ProfileUserInfoCell {

        }
        if let cell = cell as? SkillSetEditCell {
            cell.delegate = self
            cell.toggleButton.setOn(SessionUser.shared().skillset.arraySkills[index], animated: false)
            cell.label.text = SessionUser.shared().skillset.skillNames[index]//"event cell"
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
     //   skills = object as? Skillset
    }
    
    override func didSelectItem(at index: Int) {
        //self.section is the index of our click, starting at 0
        // need to populate new view controller, event view, with this info
        //TODO: have EventPageViewController present with Event we clicked on
    }
}
