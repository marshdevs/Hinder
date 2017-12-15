//
//  MemberViewCell.swift
//  HinderApp
//
//  Created by Kyle Haacker on 12/14/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class MemberViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
