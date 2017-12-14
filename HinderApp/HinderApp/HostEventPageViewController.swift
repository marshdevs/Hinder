//
//  EventPageViewController.swift
//  HinderApp
//
//  Created by Marshall Briggs on 11/13/17.
//  Copyright © 2017 TBD. All rights reserved.
//
import UIKit

class HostEventPageViewController: UIViewController {
    
    //    var event: Event;
    //
    //    public func setEvent(myEvent: Event) {
    //        event = myEvent;
    //    }
    
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    @IBOutlet weak var createEventButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func menuClicked(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "backToHomeSegue", sender: self)
    }
    
    @IBAction func createEventClicked(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "createNewEventSegue", sender: self)
    }
    
//    override func didSelectItem(at index: Int) {
//        let vc = UIStoryboard(name: "Main", bundle: nil) .instantiateViewController(withIdentifier: "EventPageViewController") as! EventPageViewController
//        vc.setEvent(event: event)
//        delegate.changeToVC(vc: vc)
//    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
