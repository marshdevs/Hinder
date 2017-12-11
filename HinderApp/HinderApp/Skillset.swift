//
//  Skillset.swift
//  HinderApp
//
//  Created by Kim Svatos on 11/8/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import IGListKit

class Skillset: NSObject, ListDiffable {
    let numSkills = 8
    var skillNames: [String]
    var arraySkills: [Bool]
    var namesOfIntegers = [Int: String]()
    var cpp: Bool
    var c: Bool
    var objc: Bool
    var swift: Bool
    var python: Bool
    var java: Bool
    var javascript: Bool
    var html: Bool
    
//    override init() {
//        arraySkills = [Bool]()
//        skillNames = [String]()
//        for _ in 0...7 {
//            arraySkills.append(false)
//        }
//        skillNames.append("C++");
//        skillNames.append("C");
//        skillNames.append("Obj-C");
//        skillNames.append("Swift");
//        skillNames.append("Python");
//        skillNames.append("Java");
//        skillNames.append("Javascript");
//        skillNames.append("Html");
//        cpp = false
//        c = false
//        objc = false
//        swift = false
//        python = false
//        java = false
//        javascript = false
//        html = false
//
//        super.init()
//    }
    
    init(json: Dictionary<String, Any>) {
        //TODO
        arraySkills = [Bool]()
        skillNames = [String]()
        for _ in 0...7 {
            arraySkills.append(true)
        }
        skillNames.append("C++");
        skillNames.append("C");
        skillNames.append("Obj-C");
        skillNames.append("Swift");
        skillNames.append("Python");
        skillNames.append("Java");
        skillNames.append("Javascript");
        skillNames.append("Html");
        cpp = false
        c = true
        objc = false
        swift = false
        python = false
        java = false
        javascript = false
        html = false
        
        super.init()
    }
    
    //MARK! listdiffable
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
