//
//  SetoranViewController.swift
//  Trashure
//
//  Created by Gus Adi on 26/10/20.
//

import UIKit

class SetoranViewController: UIViewController {
    @IBOutlet weak var setoranFullTable: UITableView!
    
    let dataSetoran = SetoranData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setoranFullTable.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)

        setoranFullTable.dataSource = self
        setoranFullTable.delegate = self
        setoranFullTable.register(UINib(nibName: "SetoranCell", bundle: nil), forCellReuseIdentifier: "setoranCell")
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "DarkBlue")!, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold)]
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")

        navigationController?.navigationBar.tintColor = UIColor(named: "DarkBlue")
    
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 22))
        
        let title = UILabel()
        title.text = "Setoran"
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
}

extension SetoranViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSetoran.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setoranCell", for: indexPath) as! SetoranCell
        
        cell.dateLabel.text = dataSetoran.data[indexPath.row].date
        cell.idLabel.text = dataSetoran.data[indexPath.row].id
        cell.statusLabel.text = dataSetoran.data[indexPath.row].status
        
        if cell.statusLabel.text == "Selesai" {
            cell.statusLabel.textColor = UIColor(named: "green")
        }
        
        return cell
    }
    
    
}
