//
//  HargaViewController.swift
//  Trashure
//
//  Created by Gus Adi on 25/10/20.
//

import UIKit

class HargaViewController: UIViewController {
    @IBOutlet weak var sampahTableView: UITableView!
    
    private let jenisSampah = JenisSampahData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampahTableView.dataSource = self
        sampahTableView.delegate = self
        sampahTableView.register(UINib(nibName: "HargaSampahCell", bundle: nil), forCellReuseIdentifier: "sampahCell")
        
        setupUI()
    }
    
    //MARK: - Customize UI
    private func setupUI() {
        self.sampahTableView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .white
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.1
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        
        let label = UILabel()
        label.textColor = UIColor(named: "DarkBlue")
        label.text = "Harga sampah"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    

}

//MARK: - Table View Delegate
extension HargaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jenisSampah.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampahCell", for: indexPath) as! HargaSampahCell
        
        let sampah = jenisSampah.data
        
        cell.imageLabelView.image = sampah[indexPath.row].image
        cell.priceLabel.text = sampah[indexPath.row].price
        cell.titleLabel.text = sampah[indexPath.row].title
        
        return cell
    }
    
    
}
