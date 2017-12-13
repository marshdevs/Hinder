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
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
