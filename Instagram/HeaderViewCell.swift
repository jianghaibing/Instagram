//
//  HeaderViewCell.swift
//  Instagram
//
//  Created by baby on 15/11/8.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

class HeaderViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.cornerRadius = avatar.bounds.width / 2
        avatar.layer.masksToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
