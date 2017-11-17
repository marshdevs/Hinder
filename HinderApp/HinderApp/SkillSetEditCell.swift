//
//  SkillSetEditCell.swift
//  HinderApp
//
//  Created by Kim Svatos on 11/16/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit
import IGListKit

class SkillSetEditCell: UICollectionViewCell {
    static let font = EventFeedFont()
    static let inset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexGrow = 1.0
            layout.marginStart = 15
            
        }
        label.font = EventFeedFont()
        label.textColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.gray
        contentView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexGrow = 1.0
        }
        
        let rowView = UIView(frame: .zero)
        rowView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexGrow = 1.0
            layout.flexDirection = .row
            layout.paddingStart = 15.0
        }
        
        let buttonView = UIView(frame: .zero)
        buttonView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.justifyContent = .center
        }
 /*
        let headerLabel = UILabel()
        headerLabel.textColor = UIColor.white
        headerLabel.text = "k"
        headerLabel.font = EventFeedFont()
        headerLabel.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginEnd = 15
        }*/
        
        let toggleButton = UISwitch()

        toggleButton.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginEnd = 15
        }
        
        let barView = UIView(frame: .zero)
        barView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = 0.2
        }
        barView.backgroundColor = .black
        
        buttonView.addSubview(toggleButton)
        rowView.addSubview(label)
        rowView.addSubview(buttonView)
        contentView.addSubview(rowView)
        contentView.addSubview(barView)
        
        //contentView.addSubview(label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = UIEdgeInsetsInsetRect(bounds, FeedEventCell.inset)
        contentView.yoga.applyLayout(preservingOrigin: true)
    }
}
