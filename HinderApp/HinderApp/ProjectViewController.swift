//
//  ProjectViewController.swift
//  HinderApp
//
//  Created by Kyle Haacker on 12/14/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - IBOutlets
    @IBOutlet weak var projectPhoto: UIImageView!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var projectSize: UILabel!
    @IBOutlet weak var projectView: UIView!
    @IBOutlet weak var projectHeader: UILabel!
    @IBOutlet weak var projectData: UILabel!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var eventHeader: UILabel!
    @IBOutlet weak var eventData: UILabel!
    @IBOutlet weak var skillsView: UIView!
    @IBOutlet weak var skillsHeader: UILabel!
    @IBOutlet weak var skillsData: UILabel!
    @IBOutlet weak var memberView: UIView!
    @IBOutlet weak var memberHeader: UILabel!
    @IBOutlet weak var memberTable: UITableView!

    var tableRows: [String] = []
    var projectId: String! = nil
    var project: Project! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load project information
        if project == nil {
            if projectId == nil {
                project = ProjectRequest().getProject(projectId: "2gvyaQqrd")
            } else {
                project = ProjectRequest().getProject(projectId: self.projectId)
            }
        }

        // Set formatting
        projectTitle.font = UIFont.boldSystemFont(ofSize: 38.0)
        projectTitle.textColor = UIColor.white
        projectSize.font = UIFont.systemFont(ofSize: 20.0)
        projectSize.textColor = UIColor.white
        projectView.backgroundColor = UIColor( red: 135/255, green: 206/255, blue:250/255, alpha: 0.3)
        eventView.backgroundColor = UIColor( red: 135/255, green: 206/255, blue:250/255, alpha: 0.3)
        skillsView.backgroundColor = UIColor( red: 135/255, green: 206/255, blue:250/255, alpha: 0.3)
        memberView.backgroundColor = UIColor( red: 135/255, green: 206/255, blue:250/255, alpha: 0.3)
        let headerFont = UIFont.boldSystemFont(ofSize: 21.0)
        let dataFont = UIFont.systemFont(ofSize: 17.0)
        projectHeader.font = headerFont
        eventHeader.font = headerFont
        skillsHeader.font = headerFont
        memberHeader.font = headerFont
        projectData.font = dataFont
        eventData.font = dataFont
        skillsData.font = UIFont.systemFont(ofSize: 15.0)
        memberTable.backgroundColor = UIColor(red:135/255, green:206/255, blue:250/255, alpha:0.4)
        
        // Set user info
        projectTitle.text = project.name
        projectSize.text = String(project.users.count) + " / " + String(project.size[1])
        projectHeader.text = "Description"
        projectData.text = project.desc
        eventHeader.text = "Event"
        let event = EventRequest().getEvent(eventId: project.eventId)
        eventData.text = event.name
        skillsHeader.text = "Project Skills"
        tableRows = project.users

        // Obtain project skills
        var count = 0
        var skillString = "No skills...yet!"
        for (skill, hasSkill) in (project.skillset.toDict() as! Dictionary<String, Bool>) {
            if hasSkill {
                if count == 0 {
                    skillString = ""
                    skillString += skill
                    count = 1
                } else {
                    skillString += (", " + skill)
                }
            }
        }
        skillsData.text = skillString
        memberHeader.text = "Project Members"

        // Get project photo
        let listener = ImageListener(imageView: projectPhoto)
        let path = ImageAction.downloadFromS3(filename: project.projectId + ".png", listener: listener)
        listener.setPath(path: path)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setProject(project: String){
        self.projectId = project
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Set up cell formatting
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberViewCell", for: indexPath) as! MemberViewCell
        
        let user = UserRequest().getUser(userId: tableRows[indexPath.row])
        
        cell.userName?.font = UIFont.boldSystemFont(ofSize: 21.0)
        cell.userId?.text = user.userId
        cell.userId?.font = UIFont.systemFont(ofSize: 1.0)
        cell.userId?.textColor = UIColor.white
        // Get photo
        let listener = ImageListener(imageView: cell.userImage)
        let path = ImageAction.downloadFromS3(filename: user.userId + ".png", listener: listener)
        listener.setPath(path: path)
        cell.userName?.text = user.name
        cell.backgroundColor = UIColor(red:135/255, green:206/255, blue:250/255, alpha:1.0)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userId = (tableRows[indexPath.row] as String!)
        let user = UserRequest().getUser(userId: userId!)
        let vc = UIStoryboard(name: "Main", bundle: nil) .instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
        vc.setUser(user: user)
        self.navigationController?.pushViewController(vc, animated: true)
        
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
