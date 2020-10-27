//
//  DetailTipsViewController.swift
//  Trashure
//
//  Created by Gus Adi on 21/10/20.
//

import UIKit

class DetailTipsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageTips: UIImageView!
    @IBOutlet weak var isiLabel: UILabel!
    
    var arrTips = TipsModel(tipsImage: nil, title: "", isi: "", date: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")

        navigationController?.navigationBar.tintColor = UIColor(named: "DarkBlue")
        
        titleLabel.text = arrTips.title
        dateLabel.text = arrTips.date
        imageTips.image = arrTips.tipsImage
        isiLabel.text = arrTips.isi
    }

}
