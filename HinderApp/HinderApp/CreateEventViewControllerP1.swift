//
//  CreateEventViewController.swift
//  HinderApp
//
//  Created by Marshall Briggs on 12/10/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class CreateEventViewControllerP1: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var eventPhoto: UIImageView!
    
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventLocation: UITextField!
    @IBOutlet weak var eventDate: UIDatePicker!
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    
//    var segueEventPhoto: UIImageView = UIImageView(image : #imageLiteral(resourceName: "placeholder"))
    var segueEventName: String = ""
    var segueEventLocation: String = ""
    var segueEventDate: Date = Date()
    var eventEditing : Int = 0
    var segueImage : UIImage = #imageLiteral(resourceName: "placeholder")
    var nextThumbNail : UIImage = #imageLiteral(resourceName: "placeholder")
    
    var segueEvent: Event = Event(json: EventRequest.getEmptyEventHandler())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let listener = ImageListener(imageView: eventPhoto)
        if(eventEditing == 1) {
            let listener = ImageListener(imageView: eventPhoto)
            let path = ImageAction.downloadFromS3(filename: segueEvent.photo + ".png", listener: listener)
            listener.setPath(path: path)
        }
        
        if(segueImage != #imageLiteral(resourceName: "placeholder")) {
            eventPhoto.image = segueImage
        }
        
        eventName.text = segueEventName
        eventLocation.text = segueEventLocation
        eventDate.date = segueEventDate
        
        self.navigationItem.rightBarButtonItem = nextButton
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    func preSetValue(event : Event) {
        
        segueEventName = event.name
        segueEventLocation = event.location
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: event.date)
        segueEventDate = date!
        segueEvent = event
        eventEditing = 1
    }
    
    func preSetNonexistingEvent(event : Event) {
        
        segueEventName = event.name
        segueEventLocation = event.location
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: event.date)
        segueEventDate = date!
        segueEvent = event
        eventEditing = 2
    }
    
    @IBAction func nextPage(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "nextCreateEventSegue", sender: self)
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
                self.eventPhoto.contentMode = .scaleAspectFit
                self.eventPhoto.image = pickedImage
            }
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                        self.eventPhoto.contentMode = .scaleAspectFit
                        self.eventPhoto.image = pickedImage
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextCreateEventSegue" {
            if let destination = segue.destination as? CreateEventViewControllerP2 {
                destination.thumbnailImage = nextThumbNail
                destination.eventName = eventName.text!
                destination.eventLocation = eventLocation.text!
                destination.eventDate = eventDate.date
                destination.eventPhotoFromPrev = eventPhoto.image!
                
                if(eventEditing == 1) {
                    destination.preSetValue(event: segueEvent)
                }
                
                if(eventEditing == 2) {
                    destination.preSetNonExistingValue(event: segueEvent)
                }
            }
        }
    }
}
