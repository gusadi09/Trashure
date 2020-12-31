//
//  NominalViewController.swift
//  Trashure
//
//  Created by Gus Adi on 09/12/20.
//

import UIKit

protocol passDataToPenukaranDelegate {
    func passDataHarga(nominal: NominalModel)
}

class NominalViewController: UIViewController {
    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var nominalTable: UITableView!
    
    var dataNominal = NominalData().data
    var currencyFormatter = NumberFormatter()
    var delegate: passDataToPenukaranDelegate?
    
    var nominal = 0
    var harga = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "id_ID")
        
        self.nominalTable.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
        
        nominalTable.register(UINib(nibName: "NominalCell", bundle: nil), forCellReuseIdentifier: "nominalCell")
        nominalTable.delegate = self
        nominalTable.dataSource = self
        
        navbarView.layer.masksToBounds = false
        navbarView.layer.shadowColor = UIColor.black.cgColor
        navbarView.layer.shadowOpacity = 0.1
        navbarView.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        navbarView.layer.shadowRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension NominalViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataNominal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = nominalTable.dequeueReusableCell(withIdentifier: "nominalCell", for: indexPath) as? NominalCell
        
        let nominalCurr = currencyFormatter.string(from: NSNumber(value: dataNominal[indexPath.row].nominal))
        let hargaCurr = currencyFormatter.string(from: NSNumber(value: dataNominal[indexPath.row].harga))
        
        cell?.nominalLabel.text = nominalCurr
        cell?.hargaLabel.text = hargaCurr
        
        cell?.selectionStyle = .none
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = NominalModel(nominal: dataNominal[indexPath.row].nominal, harga: dataNominal[indexPath.row].harga)
        
        delegate?.passDataHarga(nominal: model)
        
        navigationController?.popViewController(animated: true)
    }
}
