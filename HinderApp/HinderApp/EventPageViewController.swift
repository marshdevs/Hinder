//
//  EventPageViewController.swift
//  HinderApp
//
//  Created by Kim Svatos on 11/13/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import IGListKit

class EventPageViewController: UIViewController {
    
    var event: Event!
    //
    //    public func setEvent(myEvent: Event) {
    //        event = myEvent;
    //    }
    
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var eventImage : UIImageView!
    
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var locationLabel : UILabel!
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var createGroupButton: UIButton!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        var projectId = "filler"
        for proj in SessionUser.shared().projects {
            for eventProject in event.projects {
                if eventProject == proj {
                    projectId = proj //@KYLE this is project ID
                }
            }
        }
        //KYLE: ADD REQUESTS BELOW
        if buttonLabel.text == "View Group" { //GO TO MY PROJECT
            let vc = UIStoryboard(name: "Main", bundle: nil) .instantiateViewController(withIdentifier: "ProjectViewController") as! ProjectViewController
            vc.setProject(project: projectId)
            self.navigationController?.pushViewController(vc, animated: true)
        } else if buttonLabel.text == "Search Groups" { // GO TO SWIPE INTERFACE GEORGE
            // go to george's swipe interface
            let vc = UIStoryboard(name: "Swipe", bundle: nil) .instantiateViewController(withIdentifier: "BackgroundAnimationViewController") as! BackgroundAnimationViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else if buttonLabel.text == "Join Event" { // IDK ADD SELF TO EVENT AND THEN GO TO SWIPE??
            // insert user into event
            // self.performSegue(withIdentifier: "blah", sender: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.titleLabel.text = event.name
        self.eventImage.image = UIImage(named: "redBanner")
        self.descriptionLabel.text = event.desc
        dateLabel.text = event.date
        locationLabel.text = event.location
        
        var assignedLabel = false
        var eventId = event.eventId
        if SessionUser.shared().events.contains(eventId) {
            for proj in SessionUser.shared().projects {
                for eventProject in event.projects {
                    if eventProject == proj {
                        buttonLabel.text = "View Group"
                        assignedLabel = true
                        createGroupButton.isEnabled = false
                        createGroupButton.isHidden = true
                    }
                }
            }
            if assignedLabel == false {
                buttonLabel.text = "Search Projects"
            }
        } else {
            buttonLabel.text = "Join Event"
        }
        
        let listener = ImageListener(imageView: eventImage)
        let path = ImageAction.downloadFromS3(filename: eventId + "Photo" + ".png", listener: listener)
        listener.setPath(path: path)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func menuClicked(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "backToHomeSegue", sender: self)
    }
    @IBAction func createGroupPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "createProjectSegue", sender: self)
    }
    
    func setEvent(event: Event){
        self.event = event
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createProjectSegue" {
            if let destination = segue.destination as? CreateProjectViewController {
                destination.eventId = event.eventId
            }
        }
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

// MARK: - IGListAdapterDataSource

//extension EventPageViewController {
//
//    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
//        var items: [ListDiffable] = [ListDiffable]();
//        var eventArray = [Event]()
//        eventArray.append(event)
//        items = eventArray as [ListDiffable]
//        return items
//    }
//
//    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
//        return FeedSectionController(); //placeholder to prevent compilation errors rn
//    }
//
//
//    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
//}

