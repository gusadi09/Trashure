//
//  NotifikasiTableViewCell.swift
//  Trashure
//
//  Created by Gus Adi on 24/11/20.
//

import UIKit

class NotifikasiTableViewCell: UITableViewCell {
    @IBOutlet weak var imageNotif: UIImageView!
    @IBOutlet weak var titleNotif: UILabel!
    @IBOutlet weak var subtitleNotif: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let active = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
        active.clipsToBounds = true
        active.layer.cornerRadius = active.frame.height/2
        active.layer.masksToBounds = false
        active.backgroundColor = UIColor(named: "orange")
        
        self.accessoryView = active
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
