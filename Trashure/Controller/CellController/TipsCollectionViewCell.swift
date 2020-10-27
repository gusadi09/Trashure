//
//  TipsCollectionViewCell.swift
//  Trashure
//
//  Created by Gus Adi on 26/10/20.
//

import UIKit

class TipsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var colView: UIView!
    @IBOutlet weak var tipsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var blackView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        colView.clipsToBounds = true
        colView.layer.cornerRadius = 5
        colView.layer.shadowColor = UIColor.black.cgColor
        colView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        colView.layer.shadowOpacity = 0.1
        colView.layer.shadowRadius = 12
        colView.layer.masksToBounds = false
        
        tipsImage.clipsToBounds = true
        tipsImage.layer.cornerRadius = 5
        
        blackView.clipsToBounds = true
        blackView.layer.cornerRadius = 5
    }

}
