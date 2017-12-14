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
    
    init(json: Dictionary<String, Bool>) {
        //TODO
        
        // arraySkills is an array with the values of whether the specific skill is in the skillset
        // [false, true, true, true, ...etc]
        // skillNames is an array with the names of the skills
        // ["C++", "C", "Obj-C", "Swift", "Python", "Java", "Javascript", "Html"]
        
        arraySkills = [Bool]()
        skillNames = [String]()

        skillNames.append("C++");
        skillNames.append("C");
        skillNames.append("Obj-C");
        skillNames.append("Swift");
        skillNames.append("Python");
        skillNames.append("Java");
        skillNames.append("Javascript");
        skillNames.append("Html");

        for index in 0...7 {
            arraySkills.append(json[skillNames[index]]!)
        }

        cpp = arraySkills[0]
        c = arraySkills[1]
        objc = arraySkills[2]
        swift = arraySkills[3]
        python = arraySkills[4]
        java = arraySkills[5]
        javascript = arraySkills[6]
        html = arraySkills[7]
        
        super.init()
    }
    
    //MARK! listdiffable
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
    
    public func toDict() -> Dictionary<String, Any> {
        var resDict = Dictionary<String, Any>()
        
        for index in 0...7 {
            resDict[skillNames[index]] = arraySkills[index]
        }
        
        return resDict
    }
}
