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
    
    let profilePic: UIButton = {
        let image = UIButton()
        image.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.addTarget(self, action: #selector(HinderCreateProfile.pressed), for: .touchUpInside)
        self.view.addSubview(profilePic)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pressed() {
        signInWithFacebook()
    }
    
    func signInWithFacebook()
    {
        if (FBSDKAccessToken.current() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            return
        }
        let faceBookLoginManger = FBSDKLoginManager()
        faceBookLoginManger.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self, handler: { (result, error)-> Void in
            //result is FBSDKLoginManagerLoginResult
            if (error != nil)
            {
            }
            if (result?.isCancelled)!
            {
                //handle cancelations
            }
            if (result?.grantedPermissions.contains("email"))!
            {
                let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, picture.type(large)"])
                let _ = request?.start(completionHandler: { (connection, result, error) in
                    guard let userInfo = result as? [String: Any] else { return } //handle the error
                    
                    //The url is nested 3 layers deep into the result so it's pretty messy
                    if let imageURL = ((userInfo["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {

                        let url = URL(string: imageURL)
                        let data = try? Data(contentsOf: url!)
                        self.profilePic.setImage(UIImage(data: data!), for: .normal)
                    }
                })
            }
        })
    }
}
    

