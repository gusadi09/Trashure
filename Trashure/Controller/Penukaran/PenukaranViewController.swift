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
    
    var hargaNow = 0
    var nominalNow = 0
    var point = Int()
    
    var nominalHarga = NominalModel(nominal: 0, harga: 0)
    
    var currencyFormatter = NumberFormatter()
    
    var arrPhone = [""]
    var name = ""
    
    var height = 110
    
    var indexpath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "id_ID")
        
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
    
    @objc func segueNominal(_ sender: UIButton!) {
        let nvc = storyboard?.instantiateViewController(identifier: "nVC") as! NominalViewController
        nvc.delegate = self
        
        navigationController?.pushViewController(nvc, animated: true)
    }
    
    @objc func konfirmasiSegue(_ sender: UIButton!) {
        guard let vc = storyboard?.instantiateViewController(identifier: "konfirmasiView") as? KonfirmasiViewController else {return}
     
        let pointInTable = sender.convert(sender.bounds.origin, to: self.expandableTable)
        guard let cellIndexPath = self.expandableTable.indexPathForRow(at: pointInTable) else {return}
        point = cellIndexPath.row
        
            if data[point].isOpen == true {
                if name != "not pulsa" {
                    vc.img = data[point].img
                    vc.titles = data[point].title
                    vc.jenis = name
                    vc.hp = arrPhone.last!
                    vc.pulsa = nominalHarga.nominal
                    vc.harga = nominalHarga.harga
                } else {
                    vc.img = data[point].img
                    vc.titles = data[point].title
                    vc.jenis = data[point].title
                    vc.hp = arrPhone.last!
                    vc.pulsa = nominalHarga.nominal
                    vc.harga = nominalHarga.harga
                }
            }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PenukaranViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if data[indexPath.row].isOpen == true {
            height = 380
        } else {
            data[indexPath.row].isOpen = false
            height = 110
        }
      
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "penukaranCell", for: indexPath) as! PenukaranTableViewCell
        
        let controller = NominalViewController()
        
        controller.delegate = self
    
        cell.cellImage.image = data[indexPath.row].img
        cell.cellLabel.text = data[indexPath.row].title
        name = cell.names
        
        

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
            cell.nominalButton.isHidden = false
            
            if self.selectedIndex.row == indexPath.row {
                cell.hargaText.text = self.currencyFormatter.string(from: NSNumber(value: self.nominalHarga.harga))
                cell.nominalText.text = self.currencyFormatter.string(from: NSNumber(value: self.nominalHarga.nominal))
            } else {
                cell.hargaText.text = self.currencyFormatter.string(from: NSNumber(value: 0))
                cell.nominalText.text = self.currencyFormatter.string(from: NSNumber(value: 0))
            }
 
            cell.nominalButton.addTarget(self, action: #selector(segueNominal(_:)), for: .touchUpInside)
            cell.tukarButton.addTarget(self, action: #selector(konfirmasiSegue(_:)), for: .touchUpInside)
            
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
            cell.nominalButton.isHidden = true
        }
        
        arrPhone.append(cell.nohpField.text ?? "-")
        cell.hargaText.text = self.currencyFormatter.string(from: NSNumber(value: self.nominalHarga.harga))
        cell.nominalText.text = self.currencyFormatter.string(from: NSNumber(value: self.nominalHarga.nominal))
        
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

extension PenukaranViewController: passDataToPenukaranDelegate {
    func passDataHarga(nominal: NominalModel) {

        self.dismiss(animated: true) {
            
            self.nominalHarga = nominal
            
            self.expandableTable.reloadData()
            
//            DispatchQueue.main.async {
//                self.expandableTable.beginUpdates()
//                self.expandableTable.reloadRows(at: [self.selectedIndex], with: .automatic)
//                self.expandableTable.endUpdates()
//            }
        }
    }
}
