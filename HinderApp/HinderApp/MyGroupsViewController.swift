//
//  MyGroupsViewController.swift
//  HinderApp
//
//  Created by Kyle Haacker on 12/10/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class MyGroupsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Button to create a new project
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MyGroupsViewController.newProject))
        self.navigationItem.rightBarButtonItem = addBarButtonItem
        // Do any additional setup after loading the view.
    }

    func newProject () {
        performSegue(withIdentifier: "createNew", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
