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
    
    var skills: Skillset!
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
    
    func didFinishTask(sender: SkillSetEditCell, turnedOn: Bool) {
        // turnedOn bool will indicate TRUE if we need to newly
        // save as true, FALSE if we need to newly save FALSE
        let text = sender.label.text
        if text == "C++" {
            //TODO: send/save that C++ is now true
        } else if text == "C" {
            //TODO: send/save that C++ is now true
        } else if text == "Obj-C" {
            //TODO: send/save that C++ is now true
        }else if text == "Swift" {
            //TODO: send/save that C++ is now true
        }else if text == "Python" {
            //TODO: send/save that C++ is now true
        }else if text == "Java" {
            //TODO: send/save that C++ is now true
        }else if text == "Javascript" {
            //TODO: send/save that C++ is now true
        }else if text == "Html" {
            //TODO: send/save that C++ is now true
        }
    }
    override func numberOfItems() -> Int {
        return 8
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        if self.section == 0 {
            return CGSize(width: context.containerSize.width, height: ToggleHeight)
        }
        else {
            return CGSize(width: context.containerSize.width, height: 20)
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        // TODO: if first section, add "My Events" header
        let cellClass: AnyClass = SkillSetEditCell.self
        
        
        let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)
        
        if let cell = cell as? SkillSetEditCell {
            cell.delegate = self
            cell.toggleButton.setOn(skills.arraySkills[index], animated: false)
            cell.label.text = skills.skillNames[index]//"event cell"
        }
        return cell
    }
    
    override func didUpdate(to object: Any) {
        skills = object as? Skillset
    }
    
    override func didSelectItem(at index: Int) {
        //self.section is the index of our click, starting at 0
        // need to populate new view controller, event view, with this info
        //TODO: have EventPageViewController present with Event we clicked on
    }
}
