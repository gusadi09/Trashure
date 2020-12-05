//
//  DetailTipsViewController.swift
//  Trashure
//
//  Created by Gus Adi on 21/10/20.
//

import UIKit
import Kingfisher

class DetailTipsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageTips: UIImageView!
    @IBOutlet weak var isiLabel: UILabel!
    
    var arrTips = TipsModel(tipsImage: "", title: "", isi: "", date: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")

        navigationController?.navigationBar.tintColor = UIColor(named: "DarkBlue")
        
        let url = URL(string: arrTips.tipsImage)
        
        titleLabel.text = arrTips.title
        dateLabel.text = arrTips.date
        imageTips.kf.setImage(with: url)
        isiLabel.text = arrTips.isi
    }

}
