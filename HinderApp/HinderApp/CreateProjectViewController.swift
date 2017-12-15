//
//  CreateProjectViewController.swift
//  HinderApp
//
//  Created by Apurva Panse on 12/11/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class CreateProjectViewController: UIViewController, UITextFieldDelegate {
    
    // internal let projectId: String
    
    //internal let eventId: String
    
    //internal let name: String
    
    //internal let desc: String
    
    //internal let size: [Int]
    
    //internal let photo: String
    
    //internal let skillset: Skillset
    
    @IBOutlet weak var projectName: UITextField!
    
    @IBOutlet weak var projectDescription: UITextView!
    
    @IBOutlet weak var projectSize: UITextField!

    // Skillset
    
    @IBOutlet weak var cplusplus: UISwitch!
    @IBOutlet weak var c: UISwitch!
    @IBOutlet weak var objc: UISwitch!
    @IBOutlet weak var swift: UISwitch!
    @IBOutlet weak var python: UISwitch!
    @IBOutlet weak var java: UISwitch!
    @IBOutlet weak var js: UISwitch!
    @IBOutlet weak var html: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        // Buttons to save and cancel during project creation
        let saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(CreateProjectViewController.save))
        self.navigationItem.rightBarButtonItem = saveBarButton
        
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CreateProjectViewController.cancel))
        self.navigationItem.leftBarButtonItem = cancelBarButton

    }
    
    func save() {
        // Create project
        let _name: String! = projectName.text!
        let size : Int! = Int(projectSize.text!)
        var newProjectModel = ["projectId": "none", "eventId":"none", "projectName": _name,
                            "projectDescription": projectDescription.text, "projectSize": [size],
                            "projectPhoto": "nophotoyet", "projectUsers": [],
                            "projectSkillset": ["C++":cplusplus.isOn,
                                                "C": c.isOn,
                                                "Obj-C": objc.isOn,
                                                "Swift":swift.isOn,
                                                "Python":python.isOn,
                                                "Java":java.isOn,
                                                "Javascript":js.isOn,
                                                "Html":html.isOn]] as Dictionary<String,Any>
        let projectRequest = ProjectRequest()
        let userRequest = UserRequest()
        let projectId = projectRequest.createProject(project: Project(json: newProjectModel))
        print(projectId)
        
        print(SessionUser.shared().projects)
        SessionUser.shared().projects.append(projectId)
        print(SessionUser.shared().projects)
        userRequest.updateUser(user: SessionUser.shared())
        
        newProjectModel["projectId"] = projectId
        projectRequest.updateProject(project: Project(json: newProjectModel))

        //navigationController?.popViewController(animated: true)
        performSegue(withIdentifier: "backtoMain", sender: self)
        
    }
    
    func cancel () {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
