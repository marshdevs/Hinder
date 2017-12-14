//
//  ImageAction.swift
//  HinderApp
//
//  Created by Daniel Berestov & Marshall Briggs on 12/13/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import AWSS3
import AWSCognito

/**
 Methods to access and manage images stored in AWS S3.
 */
class ImageAction {
    
    /**
     Setup Amazon credentials for subsequent image access.
     
     - important: Correct Amazon credentials must be provided at initialization
     - returns: `void` on success
    */
    init() {
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
    
    /**
     Retrieve a stored image.
     
     - parameter filename: URL string of requested image
     - returns: `UIImage` view for the requested image
    */
    func downloadFromS3(filename : String) -> UIImage {
        
        let transferManager = AWSS3TransferManager.default()
        
        let downloadingFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(filename)
        
        let downloadRequest = AWSS3TransferManagerDownloadRequest()
        downloadRequest?.bucket = "finalhinderbucket"
        downloadRequest?.key = filename
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
    
    /**
     Upload an image to AWS.
     
     - parameter image: `UIImage` view for the image we want to store
     - parameter filename: Desired file name for stored image
     
     - returns: `void` on success. Indicates error if uploading fails.
    */
    func uploadToS3(image : UIImage, filename: String) {
        
        let transferManager = AWSS3TransferManager.default()
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent(filename)
        
        //save file locally
        do{
            if let pngImageData = UIImagePNGRepresentation(image) {
                try pngImageData.write(to: fileURL, options: .atomic)
            }
        }
        catch{}
        
        uploadRequest?.bucket = "finalhinderbucket"
        uploadRequest?.key = filename
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
