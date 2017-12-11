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
import AWSS3
import AWSCognito

class HinderCreateProfile : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let storyboardIdentifier = "HinderCreateProfileController"
    
    @IBOutlet weak var profilePic: UIButton!
    
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
        
        
        //intialize Amazon cognito credentials
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USWest2, identityPoolId: "us-west-2:9943a2f4-758f-40ff-b5c5-9d8ad1b8d5dc")
        let configuration = AWSServiceConfiguration(region: .USWest2, credentialsProvider: credentialProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        
        credentialProvider.getIdentityId().continueWith(block: { (task) -> AnyObject? in
            if (task.error != nil) {
                print("Error: " + task.error!.localizedDescription)
            }
            else {
                // the task result will contain the identity id
                let cognitoId = task.result!
                print("Cognito id: \(cognitoId)")
            }
            return task;
        })
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
                        
                        //downloadFromS3 and set image to that
                        self.firstName.text = userInfo["first_name"] as? String
                        self.lastName.text = userInfo["last_name"] as? String
                        self.profilePic.setImage(self.downloadFromS3(id: "asdfasdf"), for: .normal)
                        
                        //uploadToS3 and set image
                        //self.profilePic.setImage(image, for: .normal)
                        //self.uploadToS3(image: image!)
                    }
                })
            }
            
            else {
                
            }
        })
    }
    
    func downloadFromS3(id : String) -> UIImage {
        
        let transferManager = AWSS3TransferManager.default()

        let downloadingFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("filenameFromS3.png")
        
        let downloadRequest = AWSS3TransferManagerDownloadRequest()
        downloadRequest?.bucket = "finalhinderbucket"
        downloadRequest?.key = "uniqueId.png"
        downloadRequest?.downloadingFileURL = downloadingFileURL
        
        transferManager.download(downloadRequest!).continueWith(executor: AWSExecutor.mainThread(), block: { (task:AWSTask<AnyObject>) -> Any? in
            
            if let error = task.error as NSError? {
                if error.domain == AWSS3TransferManagerErrorDomain, let code = AWSS3TransferManagerErrorType(rawValue: error.code) {
                    switch code {
                    case .cancelled, .paused:
                        break
                    default:
                        print("Error downloading: \(downloadRequest?.key) Error: \(error)")
                    }
                } else {
                    print("Error downloading: \(downloadRequest?.key) Error: \(error)")
                }
                return nil
            }
            print("Download complete for: \(downloadRequest?.key)")
            let downloadOutput = task.result
            return nil
        })
        
        downloadRequest?.downloadProgress = {(bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) -> Void in
            DispatchQueue.main.async(execute: {() -> Void in
            })
        }
        
        return UIImage(contentsOfFile: downloadingFileURL.path)!

    }
    
    func uploadToS3(image : UIImage) {
        
        let transferManager = AWSS3TransferManager.default()
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent("filename.png")
        
        //save file locally
        do{
            if let pngImageData = UIImagePNGRepresentation(image) {
                try pngImageData.write(to: fileURL, options: .atomic)
            }
        }
        catch{}
        
        uploadRequest?.bucket = "finalhinderbucket"
        uploadRequest?.key = "uniqueId.png"
        uploadRequest?.body = fileURL
        
        transferManager.upload(uploadRequest!).continueWith(executor: AWSExecutor.mainThread(), block: { (task:AWSTask<AnyObject>) -> Any? in
            
            if let error = task.error as NSError? {
                if error.domain == AWSS3TransferManagerErrorDomain, let code = AWSS3TransferManagerErrorType(rawValue: error.code) {
                    switch code {
                    case .cancelled, .paused:
                        break
                    default:
                        print("Error uploading: \(String(describing: uploadRequest?.key)) Error: \(error)")
                    }
                } else {
                    print("Error uploading: \(String(describing: uploadRequest?.key)) Error: \(error)")
                }
                return nil
            }
            
            _ = task.result
            print("Upload complete for: \(String(describing: uploadRequest?.key))")
            return nil
        })
        
    }
}
    

