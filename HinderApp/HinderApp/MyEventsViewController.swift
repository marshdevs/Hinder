//
//  MyEventsViewController.swift
//  HinderApp
//
//  Created by Kyle Haacker on 12/10/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class MyEventsViewController: UIViewController {

    var sessionUser: User?
    let user = SessionUser.shared()
    
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let listener = ImageListener(imageView: self.image)
        let path = ImageAction.downloadFromS3(filename: SessionUser.shared().userId + ".png", listener: listener)
        listener.setPath(path: path)
        
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
