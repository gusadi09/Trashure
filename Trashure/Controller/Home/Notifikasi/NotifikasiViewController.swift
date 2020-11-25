//
//  NotifikasiViewController.swift
//  Trashure
//
//  Created by Gus Adi on 24/11/20.
//

import UIKit

class NotifikasiViewController: UIViewController {
    @IBOutlet weak var transaksiButton: UIButton!
    @IBOutlet weak var lainnyaButton: UIButton!
    @IBOutlet weak var tabelNotifikasi: UITableView!
    @IBOutlet weak var navbarView: UIView!
    
    let thickness: CGFloat = 12
    var lineView = UIView()
    var lineviewL = UIView()
    
    let notifData = NotifikasiData().data
    let notifLain = NotifikasiDataLain().data
    
    var tabelData = [NotifikasiModel]()
    
    var arrSelected = NotifikasiModel(image: nil, title: "", date: "", isi: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelData = notifData
        
        self.tabelNotifikasi.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor(named: "DarkBlue")
    
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 22))
        
        let title = UILabel()
        title.text = "Notifikasi"
        title.textColor = UIColor(named: "DarkBlue")
        title.font = UIFont(name: "SF UI Display Semibold", size: 24)
        title.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(title)
        
        let leftWidth: CGFloat = 75 // left padding
        let rightWidth: CGFloat = 75 // right padding
        let width = view.frame.width - leftWidth - rightWidth
        let offset = (rightWidth - leftWidth) / 2
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            title.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            title.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: -offset),
            title.widthAnchor.constraint(equalToConstant: width)
        ])
        
        
        self.navigationItem.titleView = container
        
        lineView = UIView(frame: CGRect(x: -60, y: transaksiButton.frame.size.height + thickness, width: navbarView.frame.size.width/2, height: 3))
        lineView.backgroundColor = UIColor(named: "green")
        lineView.clipsToBounds = true
        lineView.layer.cornerRadius = 5
        lineView.layer.masksToBounds = false
        transaksiButton.addSubview(lineView)
        
        transaksiButton.setTitleColor(UIColor(named: "green"), for: .selected)
        
        tabelNotifikasi.delegate = self
        tabelNotifikasi.dataSource = self
        
        tabelNotifikasi.register(UINib(nibName: "NotifikasiTableViewCell", bundle: nil), forCellReuseIdentifier: "notifikasiCell")
        
        self.navbarView.layer.masksToBounds = false
        self.navbarView.layer.shadowColor = UIColor.black.cgColor
        self.navbarView.layer.shadowOpacity = 0.1
        self.navbarView.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.navbarView.layer.shadowRadius = 3
    }
    
    @IBAction func notifikasiPressed(_ sender: UIButton) {
        if sender == transaksiButton {
            
            transaksiButton.addSubview(lineView)
            
            lineviewL.isHidden = true
            lineView.isHidden = false
           
            tabelData = notifData
            tabelNotifikasi.reloadData()
            
            DispatchQueue.main.async {
                self.transaksiButton.setTitleColor(UIColor(named: "green"), for: .normal)
                self.lainnyaButton.setTitleColor(.label, for: .normal)
            }
        } else {
            lineviewL = UIView(frame: CGRect(x: -70, y: lainnyaButton.frame.size.height + thickness, width: navbarView.frame.size.width/2, height: 3))
            lineviewL.backgroundColor = UIColor(named: "green")
            lineviewL.clipsToBounds = true
            lineviewL.layer.cornerRadius = 5
            lineviewL.layer.masksToBounds = false
            lainnyaButton.addSubview(lineviewL)
            
            lineView.isHidden = true
            lineviewL.isHidden = false
            
            tabelData = notifLain
            tabelNotifikasi.reloadData()
            
            DispatchQueue.main.async {
                self.lainnyaButton.setTitleColor(UIColor(named: "green"), for: .normal)
                self.transaksiButton.setTitleColor(.label, for: .normal)
            }
            
        }
    }
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension NotifikasiViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelNotifikasi.dequeueReusableCell(withIdentifier: "notifikasiCell") as? NotifikasiTableViewCell
        
        cell?.titleNotif.text = notifData[indexPath.row].title
        cell?.imageNotif.image = notifData[indexPath.row].image
        cell?.subtitleNotif.text = notifData[indexPath.row].isi
        
        cell?.titleNotif.text = self.tabelData[indexPath.row].title
        cell?.imageNotif.image = self.tabelData[indexPath.row].image
        cell?.subtitleNotif.text = self.tabelData[indexPath.row].isi
        
        cell?.selectionStyle = .none
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        self.arrSelected = tabelData[indexPath.row]
        
        DispatchQueue.main.async {
            cell?.accessoryView = .none
        }
        
        performSegue(withIdentifier: "toDetailNotif", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as? DetailNotifViewController
        
        if segue.identifier == "toDetailNotif" {
            dest?.arrNotif = arrSelected
        }
    }
}
