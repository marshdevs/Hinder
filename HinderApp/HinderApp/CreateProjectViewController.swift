//
//  CreateProjectViewController.swift
//  HinderApp
//
//  Created by Apurva Panse on 12/11/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class CreateProjectViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    // internal let projectId: String
    
    //internal let eventId: String
    
    //internal let name: String
    
    //internal let desc: String
    
    //internal let size: [Int]
    
    //internal let photo: String
    
    //internal let skillset: Skillset
    
    @IBOutlet weak var projectName: UITextField!
    
    @IBOutlet weak var projectDescription: UITextView!
    
    @IBOutlet weak var projectSize: UITextField!

    @IBOutlet weak var projectPhoto: UIImageView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    // Skillset
    
    @IBOutlet weak var cplusplus: UISwitch!
    @IBOutlet weak var c: UISwitch!
    @IBOutlet weak var objc: UISwitch!
    @IBOutlet weak var swift: UISwitch!
    @IBOutlet weak var python: UISwitch!
    @IBOutlet weak var java: UISwitch!
    @IBOutlet weak var js: UISwitch!
    @IBOutlet weak var html: UISwitch!
    
    var eventId = "none"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        projectDescription.delegate = self
        projectDescription.text = "Placeholder project description..."
        projectDescription.textColor = UIColor.lightGray
        
        // Do any additional setup after loading the view.
        
        // Buttons to save and cancel during project creation
        let saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(CreateProjectViewController.save))
        self.navigationItem.rightBarButtonItem = saveBarButton
        
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(CreateProjectViewController.cancel))
        self.navigationItem.leftBarButtonItem = cancelBarButton

    }
    
    func save() {
        // Create project
        if (self.projectName.text?.characters.count == 0) {
            self.errorLabel.text = "Project name must be greater than 0 chars."
            self.errorLabel.isHidden = false
            return
        }
        if (self.projectDescription.text?.characters.count == 0) {
            self.errorLabel.text = "Project description must be greater than 0 chars."
            self.errorLabel.isHidden = false
            return
        }
        if (Int((self.projectSize?.text)!) == nil) {
            self.errorLabel.text = "Project size must be a single integer."
            self.errorLabel.isHidden = false
            return
        }
        
        let _name: String! = projectName.text!
        let size : Int! = Int(projectSize.text!)
        
        var newProjectModel = ["projectId": self.eventId, "eventId":"none", "projectName": _name,
                            "projectDescription": projectDescription.text, "projectSize": [1, size],
                            "projectPhoto": "photoURLStillToDo", "projectUsers": [],
                            "projectSkillset": ["C++":cplusplus.isOn,
                                                "C": c.isOn,
                                                "Obj-C": objc.isOn,
                                                "Swift":swift.isOn,
                                                "Python":python.isOn,
                                                "Java":java.isOn,
                                                "Javascript":js.isOn,
                                                "Html":html.isOn]] as Dictionary<String,Any>
        let projectRequest = ProjectRequest()
        let userRequest = UserRequest()
        let eventRequest = EventRequest()
        
        let projectId = projectRequest.createProject(project: Project(json: newProjectModel))
        print(projectId)
        
        print(SessionUser.shared().projects)
        SessionUser.shared().projects.append(projectId)
        print(SessionUser.shared().projects)
        userRequest.updateUser(user: SessionUser.shared())
        
        ImageAction.uploadToS3(image: projectPhoto.image!, filename: projectId + ".png")
        
        newProjectModel["projectId"] = projectId
        newProjectModel["projectPhoto"] = projectId + ".png"
        projectRequest.updateProject(project: Project(json: newProjectModel))
        
        let thisEvent = eventRequest.getEvent(eventId: eventId)
        thisEvent.projects.append(projectId)
        eventRequest.updateEvent(event: thisEvent)

        performSegue(withIdentifier: "backtoMain", sender: self)
        
    }
    
    func cancel () {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Placeholder text view methods
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.projectDescription.textColor == UIColor.lightGray {
            self.projectDescription.text = ""
            self.projectDescription.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.projectDescription.text == "" {
            self.projectDescription.text = "Placeholder event description..."
            self.projectDescription.textColor = UIColor.lightGray
        }
    }
    
    
    // Image Picker Methods
    
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.projectPhoto.contentMode = .scaleAspectFit
                self.projectPhoto.image = pickedImage
            }
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                        self.projectPhoto.contentMode = .scaleAspectFit
                        self.projectPhoto.image = pickedImage
                    }
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            print("User do not have access to photo album.")
        case .denied:
            print("User has denied the permission.")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
