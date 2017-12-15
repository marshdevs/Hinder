//
//  HamburgerMenuViewController.swift
//  HinderApp
//
//  Created by Kyle Haacker on 12/9/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class HamburgerMenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let hamburgerMenu = UIBarButtonItem(image:UIImage(named: "hamburger"), style: .plain, target: self, action: #selector(HamburgerMenuViewController.menuClicked))
        navigationItem.rightBarButtonItem = hamburgerMenu
        
        let barButton = UIBarButtonItem(image:UIImage(named: "home"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(HamburgerMenuViewController.barButtonClicked))
        navigationItem.leftBarButtonItem = barButton
        
        
        
        //navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    func menuClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func barButtonClicked() {
        let vc = UIStoryboard(name: "Main", bundle: nil) .instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
}
