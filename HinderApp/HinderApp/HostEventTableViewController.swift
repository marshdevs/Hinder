//
//  HostEventTableViewController.swift
//  HinderApp
//
//  Created by Marshall Briggs on 12/13/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class HostEventTableViewController: UITableViewController {
    
    @IBOutlet weak var hamburgerMenu: UIBarButtonItem!
    @IBOutlet weak var createEventButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let eventRequest = EventRequest()

        SessionHost.shared().events = eventRequest.getHostEvents(email: SessionHost.shared().email)["events"] as! [String]
        SessionHost.shared().populatedEvents = eventRequest.batchGetEvents(eventIds: SessionHost.shared().events)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HostEventCell")
        
        navigationItem.setHidesBackButton(true, animated: true)
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SessionHost.shared().events.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Events"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HostEventCell", for: indexPath)
        
        let event = SessionHost.shared().populatedEvents[indexPath.row] as! Event
        cell.textLabel?.text = event.name
        return cell
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
    
    // Maybe for later
    //    var event: Event;
    //
    //    public func setEvent(myEvent: Event) {
    //        event = myEvent;
    //    }
    
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    //    override func didSelectItem(at index: Int) {
    //        let vc = UIStoryboard(name: "Main", bundle: nil) .instantiateViewController(withIdentifier: "EventPageViewController") as! EventPageViewController
    //        vc.setEvent(event: event)
    //        delegate.changeToVC(vc: vc)
    //    }
    
}