/*
 This file declares the nav bar at the top, which consists of
 a settings button on the left, hamburger menu on right,
 and title in the center.
 
 */

import UIKit

class HinderNavigationBar: UINavigationBar {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.text = "Hinder"
        label.font = TitleFont()
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        barTintColor = hinderBlue()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let titleWidth: CGFloat = 120
        titleLabel.frame = CGRect(x: (bounds.width/2 - titleWidth/2), y: 0, width: titleWidth, height: bounds.height)
    }
    
}
