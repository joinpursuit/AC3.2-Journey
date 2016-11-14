//
//  YelpResultTableViewCell.swift
//  Journey
//
//  Created by Jermaine Kelly on 11/8/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class BusinessResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var businessCardView: UIView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessAddressLabel: UILabel!
    @IBOutlet weak var starRatingImage: UIImageView!
   
    
    static let Identifier = "YelpResultIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       // self.frame.height
        
        
        self.selectionStyle = .none
        businessCardView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0,1.0,1.0,1.0])
        businessCardView.layer.masksToBounds = false
        businessCardView.layer.cornerRadius = 10.0
        businessCardView.layer.shadowOffset = CGSize(width: 1, height: 1)
        businessCardView.layer.shadowOpacity = 0.2
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
