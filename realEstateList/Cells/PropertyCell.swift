//
//  PropertyCell.swift
//  realEstateList
//
//  Created by Erik Hede on 02/06/2019.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit
import SDWebImage

class PropertyCell: UITableViewCell {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var propertyImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0.926155746, green: 0.9410773516, blue: 0.9455420375, alpha: 1))
        propertyImageView.contentMode = .scaleAspectFill
        propertyImageView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func loadImageFromURL(url: String) {
        propertyImageView.sd_setImage(with: URL(string: url), placeholderImage: nil)
    }
    
    
}
