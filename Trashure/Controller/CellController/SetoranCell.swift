//
//  SetoranCell.swift
//  Trashure
//
//  Created by Gus Adi on 25/10/20.
//

import UIKit

class SetoranCell: UITableViewCell {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 5
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        cellView.layer.shadowOpacity = 0.1
        cellView.layer.shadowRadius = 12
        cellView.layer.masksToBounds = false

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
