//
//  LoginViewController.swift
//  HinderApp
//
//  Created by Kyle Haacker on 12/8/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class HostLoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let backItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(LoginViewController.back(sender:)))
        self.navigationItem.backBarButtonItem = backItem
        navigationItem.setHidesBackButton(false, animated: true)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HostLoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
        print("Host login attempt")
        let eventRequest = EventRequest()
        let dummyHost = eventRequest.authenticateHost(email: "dummyHost@hinder.com", password: "pandapanda")
        if (dummyHost["authenticated"] as! Bool == true) {
            SessionHost.setupSharedInstance(host: ["email": "dummyHost@hinder.com", "events": dummyHost["events"]])
            self.performSegue(withIdentifier: "hostAuthenticatedSegue", sender: self)
        }
    }
    
    @IBAction func userRegister(_ sender: UIButton) {
        // TODO: Need to transition to Profile Creation
        print("Host register")
        let eventRequest = EventRequest()
        if (isValidEmail(testStr: self.email.text!)) {
            if ((self.password.text?.characters.count)! >= 8) {
                let host = eventRequest.authenticateHost(email: self.email.text!, password: self.password.text!)
                if (host["authenticated"] as! Bool == true) {
                    SessionHost.setupSharedInstance(host: ["email": self.email.text!, "events": host["events"]])
                    self.performSegue(withIdentifier: "hostAuthenticatedSegue", sender: self)
                } else {
                    self.loginErrorLabel.isHidden = false
                    self.loginErrorLabel.text = "Invalid password."
                }
            } else {
                self.loginErrorLabel.isHidden = false
                self.loginErrorLabel.text = "Passwords must be at least 8 characters."
            }
        } else {
            self.loginErrorLabel.isHidden = false
            self.loginErrorLabel.text = "Please enter a valid email."
        }
    }
    
    func back(sender: UIBarButtonItem) {
        let newViewController = UserTypeViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
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

