//
//  UserViewController.swift
//  HinderApp
//
//  Created by Kyle Haacker on 12/13/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userOccupation: UILabel!
    @IBOutlet weak var skillsHeader: UILabel!
    @IBOutlet weak var skillsData: UILabel!
    @IBOutlet weak var skillsView: UIView!
    @IBOutlet weak var projectsHeader: UILabel!
    @IBOutlet weak var projectsView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var tableRows: [String] = []
    var user: User! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Load user information
        // TODO: Fix segues
        if user == nil {
            user = SessionUser.shared()
            //user = UserRequest().getUser(userId: "xR1KLg9gN")
            //user = UserRequest().getUser(userId: "z7zyN9b2r")
        }
        
        let userInfo = SessionUser.extractModel(user: user)
        let userSkills = userInfo["userSkillset"] as? Dictionary<String, Bool>
        tableRows = userInfo["userProjects"] as! [String]
        
        // Set formatting of various UI elements
        userName.font = UIFont.boldSystemFont(ofSize: 24.0)
        userOccupation.font = UIFont.italicSystemFont(ofSize: 20.0)
        skillsHeader.font = UIFont.boldSystemFont(ofSize: 21.0)
        skillsData.font = UIFont.systemFont(ofSize: 17.0)
        
        headerView.layer.borderColor = UIColor.gray.cgColor
        headerView.layer.borderWidth = 2.0
        detailsView.backgroundColor = UIColor( red: 135/255, green: 206/255, blue:250/255, alpha: 0.3)
        skillsView.backgroundColor = UIColor( red: 135/255, green: 206/255, blue:250/255, alpha: 0.6)
        skillsView.layer.borderColor = UIColor.gray.cgColor
        skillsView.layer.borderWidth = 2.0
        projectsHeader.font = UIFont.boldSystemFont(ofSize: 21.0)
        projectsView.layer.borderColor = UIColor.gray.cgColor
        projectsView.layer.borderWidth = 2.0
        projectsView.backgroundColor = UIColor(red:135/255, green:206/255, blue:250/255, alpha:0.6)
        tableView.backgroundColor = UIColor(red:135/255, green:206/255, blue:250/255, alpha:0.4)
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.borderWidth = 1.0
        
        // Obtain user skills
        var count = 0
        var skillString = "No skills...yet!"
        for (skill, hasSkill) in userSkills! {
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
        
        // Set user info
        userName.text = userInfo["userName"] as? String
        userOccupation.text = userInfo["userOccupation"] as? String
        skillsHeader.text = "Skills"
        skillsData.text = skillString
        projectsHeader.text = "Current Projects"
        
        // Get user photo
        let listener = ImageListener(imageView: userPhoto)
        let path = ImageAction.downloadFromS3(filename: user.userId + ".png", listener: listener)
        listener.setPath(path: path)
    }
    
    func setImage (asset: UIImage, cell: UIImageView) {
        cell.image = asset
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Set up cell formatting
        let cell = tableView.dequeueReusableCell(withIdentifier: "userProjectCell", for: indexPath) as! UserProjectViewCell
        cell.projectTitle?.font = UIFont.boldSystemFont(ofSize: 17.0)
        cell.backgroundColor = UIColor(red:135/255, green:206/255, blue:250/255, alpha:1.0)
        
        // Get user project and event it is for
        let project = ProjectRequest().getProject(projectId: tableRows[indexPath.row])
        let event = EventRequest().getEvent(eventId: project.eventId)
        cell.projectTitle?.text = project.name
        cell.projectEvent?.text = event.name
        
        // TODO: Get project photo
        /*let listener = ImageListener(imageView: cell.projectImage)
        let path = ImageAction.downloadFromS3(filename: project.projectId + ".png", listener: listener)
        listener.setPath(path: path)*/
        let randomIndex = Int(arc4random_uniform(UInt32(images.count)))
        cell.projectImage.image = UIImage(named: images[randomIndex])
        
        return cell
    }
    
    func setUser(user: User){
        self.user = user
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
