//
//  KonfirmasiViewController.swift
//  Trashure
//
//  Created by Gus Adi on 09/12/20.
//

import UIKit

class KonfirmasiViewController: UIViewController {
    @IBOutlet weak var layananImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var jenisLabel: UILabel!
    @IBOutlet weak var nomorHpLabel: UILabel!
    @IBOutlet weak var pulsaLabel: UILabel!
    @IBOutlet weak var hargaLabel: UILabel!
    @IBOutlet weak var tukarButton: UIButton!
    @IBOutlet weak var allView: UIView!
    
    var img = UIImage()
    var titles = ""
    var jenis = ""
    var hp = ""
    var pulsa = 0
    var harga = 0
    
    var currencyFormatter = NumberFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "id_ID")
        
        layananImage.image = img
        titleLabel.text = titles
        jenisLabel.text = jenis
        nomorHpLabel.text = hp
        pulsaLabel.text = self.currencyFormatter.string(from: NSNumber(value: self.pulsa))
        hargaLabel.text = self.currencyFormatter.string(from: NSNumber(value: self.harga))
        
        tukarButton.clipsToBounds = true
        tukarButton.layer.cornerRadius = 5
        tukarButton.layer.masksToBounds = false
        
        allView.clipsToBounds = true
        allView.layer.cornerRadius = 5
        allView.layer.shadowColor = UIColor.black.cgColor
        allView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        allView.layer.shadowOpacity = 0.1
        allView.layer.shadowRadius = 12
        allView.layer.masksToBounds = false
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .white
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "DarkBlue")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold)]
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")

        navigationController?.navigationBar.tintColor = UIColor(named: "DarkBlue")
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 22))
        
        let title = UILabel()
        title.text = "Konfirmasi"
        title.textColor = UIColor(named: "DarkBlue")
        title.font = UIFont(name: "SF UI Display Semibold", size: 24)
        title.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(title)
        
        let leftWidth: CGFloat = 55 // left padding
        let rightWidth: CGFloat = 75 // right padding
        let width = view.frame.width - leftWidth - rightWidth
        let offset = (rightWidth - leftWidth) / 2
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: container.topAnchor, constant: -10),
            title.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            title.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: -offset),
            title.widthAnchor.constraint(equalToConstant: width)
        ])
        
        
        self.navigationItem.titleView = container
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.1
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
    }
    
    @IBAction func tukarPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toKonfirmasiBerhasil", sender: self)
    }
}
