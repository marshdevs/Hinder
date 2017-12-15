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
    
    @IBOutlet weak var backtoMain: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Button to create a new project
        
        let projectRequest = ProjectRequest()
        let userRequest = UserRequest()
        
        SessionUser.shared().projects = userRequest.getUser(userId: SessionUser.shared().userId).projects
        SessionUser.shared().populatedProjects = projectRequest.batchGetProjects(projectIds: SessionUser.shared().projects)

        self.tableView.register(UITableViewCell.self,forCellReuseIdentifier: "UserProjectCell")
        tableView.reloadData()
        
    }
    
    @IBAction func createProjectClicked(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "createNewProject", sender: self)
    }
    
    @IBAction func backToMain(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "backtoMenu", sender: self)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SessionUser.shared().populatedProjects.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Projects"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserProjectCell", for: indexPath)
        let project = SessionUser.shared().populatedProjects[indexPath.row] as! Project
        cell.textLabel?.text = project.name

        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
