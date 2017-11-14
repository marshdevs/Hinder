//
//  FeedEventCell.swift
//  HinderApp
//
//  Created by Kim Svatos on 11/10/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class FeedEventCell: UICollectionViewCell {
    
    static let font = EventFeedFont()
    static let inset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.font = EventFeedFont()
        label.textColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.gray
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = UIEdgeInsetsInsetRect(bounds, FeedEventCell.inset)
    }
    
}
