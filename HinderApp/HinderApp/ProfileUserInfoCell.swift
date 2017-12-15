//
//  ProfileUserInfoCell.swift
//  HinderApp
//
//  Created by Kim Svatos on 12/14/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import YogaKit

class ProfileUserInfoCell: UICollectionViewCell, UITextViewDelegate {
    
    static let font = EventFeedFont()
    static let inset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    var user : User!
    var delegate : UITextViewDelegate!
    
    let userName: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.font = EventFeedFont()
        //label.textColor = UIColor.red
        label.text = SessionUser.shared().name
        return label
    }()
    
    let profPic: UIImage = {
        let prof = UIImage(named: "facebook")
        
        return prof!
    }()
    
    let iView : UIImageView = {
        let iView = UIImageView(image: UIImage(named: "facebook"))
        iView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = 120.0
            layout.height = 120.0
            layout.alignSelf = .center
        }
        iView.backgroundColor = UIColor.clear
        return iView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    let occText : UITextView = {
    //occText.delegate = self
        let occText = UITextView()
    occText.configureLayout{ (layout) in
    layout.isEnabled = true
    layout.paddingTop = 14.0
    layout.alignSelf = .flexStart
    layout.flexGrow = 1.0
    }
    occText.font = .systemFont(ofSize: 15.0)
    occText.text = SessionUser.shared().occupation
    return occText
    }()
    
    let descriptionView : UIView = {
        let view = UIView()
        view.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexDirection = .row
            layout.paddingStart = 20.0
            layout.paddingTop = 14.0
            layout.marginLeft = 13.0
        }
        let occLabel = UILabel()
        occLabel.configureLayout { (layout) in
            layout.isEnabled = true
            layout.alignSelf = .flexStart
            layout.paddingTop = 14.0
            layout.paddingLeft = 25.0
            layout.width = 120.0
        }
        occLabel.font = .boldSystemFont(ofSize: 17.0)
        occLabel.text = "Occupation: "
        view.addSubview(occLabel)
        
       // let occText = UITextView()
      //  occText.delegate = self.delegate
       // occText.configureLayout{ (layout) in
        //    layout.isEnabled = true
         //   layout.paddingTop = 14.0
          //  layout.alignSelf = .flexStart
           // layout.flexGrow = 1.0
       // }
        //occText.font = .systemFont(ofSize: 15.0)
        //o/ccText.text = SessionUser.shared().occupation
        //view.addSubview(occText)
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        SessionUser.shared().occupation = textView.text
       // print(textView.text); //the textView parameter is the textView where text was changed
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // let randomIndex = Int(arc4random())%images.count
        contentView.backgroundColor = UIColor.white
        //contentView.backgroundColor = UIColor(patternImage: UIImage(named: images[randomIndex])!)
        contentView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexGrow = 1.0
            //layout.alignItems = .center
            // this was most recent layout.justifyContent = .center
            //layout.marginStart = 15
        }
        userName.configureLayout { (layout) in
            layout.isEnabled = true
            layout.paddingTop = 23.0
            layout.alignSelf = .center
        }
        contentView.addSubview(userName)
        contentView.addSubview(iView)
        occText.delegate = self
        descriptionView.addSubview(occText)
        contentView.addSubview(descriptionView)
        contentView.yoga.applyLayout(preservingOrigin: true)
    }
    
}
