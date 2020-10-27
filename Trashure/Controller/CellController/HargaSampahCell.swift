//
//  HargaSampahCell.swift
//  Trashure
//
//  Created by Gus Adi on 25/10/20.
//

import UIKit

class HargaSampahCell: UITableViewCell {

    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var imageLabelView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelView.clipsToBounds = true
        labelView.layer.cornerRadius = 5
        labelView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        labelView.layer.shadowColor = UIColor.black.cgColor
        labelView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        labelView.layer.shadowOpacity = 0.1
        labelView.layer.shadowRadius = 12
        labelView.layer.masksToBounds = false
        
        imageLabelView.clipsToBounds = true
        imageLabelView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
