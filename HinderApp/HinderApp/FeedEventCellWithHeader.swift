//
// same as FeedEvent Cell, but will also have a header to indicate start of 
// "my events" or "events near you"
//

import UIKit
import YogaKit


class FeedEventCellWithHeader: UICollectionViewCell {
    
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
        let headerView = UIView(frame: .zero)
        headerView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = 34.0
            layout.justifyContent = .center
        }
        headerView.backgroundColor = UIColor.black
        
        let headerLabel = UILabel()
        headerLabel.textColor = UIColor.white
        headerLabel.text = "My Enrolled Events"
        headerLabel.font = EventFeedFont()
        headerLabel.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginStart = 15
        }
        
        headerView.addSubview(headerLabel)
        contentView.addSubview(headerView)
        contentView.addSubview(label)
        
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
