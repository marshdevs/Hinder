//
//  UserProjectViewCell.swift
//  HinderApp
//
//  Created by Kyle Haacker on 12/13/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import UIKit

class UserProjectViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var projectEvent: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
