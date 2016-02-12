//
//  ChatCell.swift
//  Chat
//
//  Created by Evan on 2/11/16.
//  Copyright © 2016 EvanTragesser. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
  
  @IBOutlet weak var chatTextLabel: UILabel!
  @IBOutlet weak var userLabel: UILabel!
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
