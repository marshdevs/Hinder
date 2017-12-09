//
//  LoginViewController.swift
//  HinderApp
//
//  Created by Kyle Haacker on 12/8/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions
    
    // Keyboard navigation
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        if self.email.isEqual(textField) {
            self.password.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    

    @IBAction func userLogin(_ sender: UIButton) {
        // TODO: Need to authenticate, transition to HomeViewController
        print("User logged in")
    }
    
    @IBAction func userRegister(_ sender: UIButton) {
        // TODO: Need to transition to Profile Creation
        print("User register")
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
