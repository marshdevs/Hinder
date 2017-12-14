//
//  Skillset.swift
//  HinderApp
//
//  Created by Kim Svatos on 11/8/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import IGListKit

/**
 Stores information about the various languages, technologies that a User is proficient in.
 Maps language names (e.g., `cpp`) to a boolean indicate whether the user knows (true) the language or not (false).
 * `cpp` (Bool)
 * `c` (Bool)
 * `objc` (Bool)
 * `swift` (Bool)
 * `python` (Bool)
 * `java` (Bool)
 * `javascript` (Bool)
 * `html` (Bool)
 */
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
    
    /**
     Create a Skillset object.
     
     - parameter json: Dictionary that indicates whether certain languages are known (or not) by the User.
     
     - important: Input parameter 'json' must be formatted with the following key-value entries:
     * "C++": Bool
     * "C": Bool
     * "Obj-C": Bool
     * "Swift": Bool
     * "Python": Bool
     * "Java": Bool
     * "Javascript": Bool
     * "Html": Bool
     
     - returns: Void. On success, correctly initializes all fields for the Skillset object
    */
    init(json: Dictionary<String, Bool>) {
        //TODO
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

    /**
     Composes Skillset information in format Dictionary<String, Any>
     
     - important: Return value will be formatted with the following key-value entries.
     * "C++": Bool
     * "C": Bool
     * "Obj-C": Bool
     * "Swift": Bool
     * "Python": Bool
     * "Java": Bool
     * "Javascript": Bool
     * "Html": Bool
     
     - returns: A Dictionary<String, Any> that indicates the languages known (and the languages not known) by the User.
     */
    public func toDict() -> Dictionary<String, Any> {
        var resDict = Dictionary<String, Any>()
        
        for index in 0...7 {
            resDict[skillNames[index]] = arraySkills[index]
        }
        
        return resDict
    }
}
