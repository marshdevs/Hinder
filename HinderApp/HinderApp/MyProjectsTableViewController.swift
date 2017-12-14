//
//  MyProjectsTableViewController.swift
//  HinderApp
//
//  Created by Apurva Panse on 12/14/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class MyProjectsTableViewController : UITableViewController {
    
    @IBOutlet weak var createNew: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Button to create a new project
        
    }
    
    @IBAction func createProjectClicked(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "createNewProject", sender: self)
    }

}
