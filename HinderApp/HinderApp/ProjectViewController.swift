//
//  ProjectViewController.swift
//  HinderApp
//
//  Created by Kyle Haacker on 12/14/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var projectPhoto: UIImageView!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var projectSize: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionHeader: UILabel!
    @IBOutlet weak var descriptionData: UILabel!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var memberView: UIView!
    @IBOutlet weak var eventHeader: UILabel!
    @IBOutlet weak var eventDescription: UILabel!

    var tableRows: [String] = []
    var project: Project! = nil
    
    //xR14Akq8l
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Load correct project
        if project == nil {
            //project = ProjectRequest().getProject(projectId: "xR14Akq8l")
        }
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
