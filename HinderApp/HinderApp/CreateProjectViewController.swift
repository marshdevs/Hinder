//
//  CreateProjectViewController.swift
//  HinderApp
//
//  Created by Apurva Panse on 12/11/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class CreateProjectViewController: UIViewController, UITextFieldDelegate {
    
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
        print("Save")
    }
    
    func cancel () {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
