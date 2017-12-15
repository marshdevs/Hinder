//
//  ImageListener.swift
//  HinderApp
//
//  Created by Marshall Briggs on 12/14/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class ImageListener {
    
    var imageView: UIImageView
    var path = ""
    
    init(imageView: UIImageView) {
        self.imageView = imageView
    }
    
    func notify() {
        self.imageView.image = UIImage(contentsOfFile: path)
    }
    
    func setPath(path: String) {
        self.path = path
    }
}
