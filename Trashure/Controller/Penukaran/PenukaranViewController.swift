//
//  PenukaranViewController.swift
//  Trashure
//
//  Created by Gus Adi on 05/12/20.
//

import UIKit

class PenukaranViewController: UIViewController {
    @IBOutlet weak var expandableTable: UITableView!
    
    var selectedIndex: IndexPath = IndexPath()
    var data = PenukaranData().data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.expandableTable.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)

        expandableTable.dataSource = self
        expandableTable.delegate = self
        
        expandableTable.register(UINib(nibName: "PenukaranTableViewCell", bundle: nil), forCellReuseIdentifier: "penukaranCell")
        
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
        label.text = "Penukaran"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    
}

extension PenukaranViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 110
            if data[indexPath.row].isOpen == true {
                height = 380
            } else {
                height = 110
            }
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "penukaranCell", for: indexPath) as! PenukaranTableViewCell
    
        cell.cellImage.image = data[indexPath.row].img
        cell.cellLabel.text = data[indexPath.row].title
        
        if data[indexPath.row].isOpen == true {
            cell.dropdownImage.image = UIImage(named: "arrowUp")
            cell.hargaText.isHidden = false
            cell.hargalabel.isHidden = false
            cell.nohpField.isHidden = false
            cell.nohpLabel.isHidden = false
            cell.nominalLabel.isHidden = false
            cell.nominalText.isHidden = false
            cell.separatorOne.isHidden = false
            cell.openNominalButton.isHidden = false
            cell.tukarButton.isHidden = false
            cell.separatorTwo.isHidden = false
        } else {
            cell.dropdownImage.image = UIImage(named: "arrowDown")
            cell.hargaText.isHidden = true
            cell.hargalabel.isHidden = true
            cell.nohpField.isHidden = true
            cell.nohpLabel.isHidden = true
            cell.nominalLabel.isHidden = true
            cell.nominalText.isHidden = true
            cell.separatorOne.isHidden = true
            cell.openNominalButton.isHidden = true
            cell.tukarButton.isHidden = true
            cell.separatorTwo.isHidden = true
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        
        if data[indexPath.row].isOpen == true {
            data[indexPath.row].isOpen = false
            DispatchQueue.main.async {
                tableView.beginUpdates()
                tableView.reloadRows(at: [self.selectedIndex], with: .automatic)
                tableView.endUpdates()
            }
        } else {
            data[indexPath.row].isOpen = true
            tableView.beginUpdates()
            tableView.reloadRows(at: [selectedIndex], with: .automatic)
            tableView.endUpdates()
        }
        
    }
}
