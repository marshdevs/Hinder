//
//  CreateEventViewControllerP2.swift
//  HinderApp
//
//  Created by Marshall Briggs on 12/10/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class CreateEventViewControllerP2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var eventPhoto: UIImageView!
    
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var eventThumbnail: UIImageView!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    var eventName = "empty"
    var eventLocation = "empty"
    var eventDate = Date()
    var eventPhotoFromPrev = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        self.eventPhoto.image = eventPhotoFromPrev
    }
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        var newEventModel = ["eventId": "none", "eventName": eventName, "eventDate": eventDate.toString(dateFormat: "yyyy-MM-dd HH:mm"), "eventLocation": eventLocation, "eventDescription": eventDescription.text, "eventPhoto": "photoURLStillToDo", "eventThumbnail": "photoURLStillToDo", "eventProjects": [], "eventUsers": []] as Dictionary<String, Any>
        let eventRequest = EventRequest()
        let eventId = eventRequest.createEvent(event: Event(json: newEventModel))
        print(eventId)
        
        let imageAction = ImageAction()
        imageAction.uploadToS3(image: eventPhotoFromPrev, filename: eventId + "Photo")
        imageAction.uploadToS3(image: eventThumbnail.image!, filename: eventId + "Thumb")
        
        newEventModel["eventId"] = eventId
        newEventModel["eventPhoto"] = eventId + "Photo"
        newEventModel["eventThumbnail"] = eventId + "Thumb"
        eventRequest.updateEvent(event: Event(json: newEventModel))
    }
    
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
                self.eventThumbnail.contentMode = .scaleAspectFit
                self.eventThumbnail.image = pickedImage
            }
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                        self.eventThumbnail.contentMode = .scaleAspectFit
                        self.eventThumbnail.image = pickedImage
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

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
