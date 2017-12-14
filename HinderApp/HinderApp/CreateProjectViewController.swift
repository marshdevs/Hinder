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
        print(projectName.text)
        print(Int(projectSize.text!))
        print(projectDescription.text)
        print(cplusplus.isOn)
        print(c.isOn)
        print(objc.isOn)
        print(swift.isOn)
        print(python.isOn)
        print(java.isOn)
        print(js.isOn)
        print(html.isOn)
        
        navigationController?.popViewController(animated: true)
    }
    
    func cancel () {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
