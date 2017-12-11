//
//  CreateEventViewController.swift
//  HinderApp
//
//  Created by Marshall Briggs on 12/10/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class CreateEventViewControllerP1: UIViewController {
    
    @IBOutlet weak var eventPhoto: UIImageView!
    
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventLocation: UITextField!
    @IBOutlet weak var eventDate: UIDatePicker!
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = nextButton
    }
    
}
