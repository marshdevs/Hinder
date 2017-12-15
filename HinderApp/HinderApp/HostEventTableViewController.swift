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
        print(SessionHost.shared().events)
        SessionHost.shared().events = eventRequest.getHostEvents(email: SessionHost.shared().email)["events"] as! [String]
        print(SessionHost.shared().events)
        SessionHost.shared().populatedEvents = eventRequest.batchGetEvents(eventIds: SessionHost.shared().events)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HostEventCell")
        
        navigationItem.setHidesBackButton(true, animated: true)
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    @IBAction func editEvent() {
        self.performSegue(withIdentifier: "createNewEventSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            let eventRequest = EventRequest()
            let event = SessionHost.shared().populatedEvents[indexPath.row] as! Event
            eventRequest.deleteEvent(eventId: event.eventId)
            SessionHost.shared().populatedEvents.remove(at: indexPath.row)
            SessionHost.shared().events.remove(at: indexPath.row)
            eventRequest.updateHost(email: SessionHost.shared().email, events: SessionHost.shared().events)
            
            tableView.reloadData()
        }
        delete.backgroundColor = UIColor.red
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            self.performSegue(withIdentifier: "createNewEventSegue", sender: SessionHost.shared().populatedEvents[indexPath.row] as! Event)
        }
        edit.backgroundColor = UIColor.blue
        
        return [delete, edit]
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "createNewEventSegue") {
            let createEventPage1:CreateEventViewControllerP1 = segue.destination as! CreateEventViewControllerP1
            createEventPage1.preSetValue(event : sender as! Event)
        }
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
