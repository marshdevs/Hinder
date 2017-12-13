//
//  HinderCreateProfile.swift
//  HinderApp
//
//  Created by Daniel Berestov on 11/12/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class HinderCreateProfile : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let storyboardIdentifier = "HinderCreateProfileController"
    
    @IBOutlet weak var profilePic: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    
    //    let firstName : UITextField = {
//        let field = UITextField()
//        field.frame = CGRect(x: 100, y: 200, width: 100, height: 200)
//        field.borderStyle = .line
//        field.text = "First Name"
//        return field
//    }()
//
//    let lastName : UILabel = {
//        let field = UILabel()
//        field.frame = CGRect(x: 200, y: 550, width: 50, height: 50)
//        field.text = "Last Name"
//        return field
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.addTarget(self, action: #selector(HinderCreateProfile.pressed), for: .touchUpInside)
//        self.view.addSubview(profilePic)
//        self.view.addSubview(firstName)
//        self.view.addSubview(lastName)
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //set the objects in the view
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton)  {
            self.performSegue(withIdentifier: "facebookLoginSegue", sender: self)
    }

    func pressed() {
        signInWithFacebook()
    }
    
    func signInWithFacebook()
    {
        if (FBSDKAccessToken.current() != nil)
        {
            return
        }
        let faceBookLoginManager = FBSDKLoginManager()
        faceBookLoginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self, handler: { (result, error)-> Void in
            //result is FBSDKLoginManagerLoginResult
            if (error != nil)
            {
                print(error as Any)
            }
            else if (result?.isCancelled)!
            {
                
            }
            else if (result?.grantedPermissions.contains("email"))!
            {
                
                let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, picture.type(large)"])
                let _ = request?.start(completionHandler: { (connection, result, error) in
                    guard let userInfo = result as? [String: Any] else { return } //handle the error
                    
                    //The url is nested 3 layers deep into the result so it's pretty messy
                    if let imageURL = ((userInfo["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {

                        let url = URL(string: imageURL)
                        let data = try? Data(contentsOf: url!)
                        let image = UIImage(data: data!)
                        
                        let userRequest = UserRequest()
                        let userId = userRequest.getId(email: userInfo["email"] as! String)
                        if let existingUser = userRequest.getUser(userId: userId) as? User {
                            SessionUser.setupSharedInstance(user: userRequest.getUser(userId: userId))
                            print(SessionUser.shared())
                        } else {
                            var newUser = User(json: User.emptyUserHandler)
                            newUser.userId = userId
                            newUser.photo = imageURL
                            newUser.name = (userInfo["first_name"] as! String) + " " + (userInfo["last_name"] as! String)
                            let _ = userRequest.createUser(user: newUser)
                            SessionUser.setupSharedInstance(user: newUser)
                            print(SessionUser.shared())
                        }
                        
                        self.profilePic.setImage(image, for: .normal)
                        self.firstName.text = userInfo["first_name"] as? String
                        self.lastName.text = userInfo["last_name"] as? String
                        
                        //downloadFromS3 and set image to that
//                        self.firstName.text = userInfo["first_name"] as? String
//                        self.lastName.text = userInfo["last_name"] as? String
//                        self.profilePic.setImage(self.downloadFromS3(id: "asdfasdf"), for: .normal)
                        
                        //uploadToS3 and set image
                        //self.profilePic.setImage(image, for: .normal)
                        //self.uploadToS3(image: image!)
                        self.loginButton.isEnabled = true
                    }
                })
            }
            
            else {
                
            }
        })
    }
    
    /////
    
}
    

