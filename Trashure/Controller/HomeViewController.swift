//
//  HomeViewController.swift
//  Trashure
//
//  Created by Gus Adi on 21/10/20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var indikatorSaldoView: UIView!
    @IBOutlet weak var viewDompet: UIView!
    @IBOutlet weak var trashbagLabel: UILabel!
    @IBOutlet weak var connectedLabel: UILabel!
    @IBOutlet weak var setoranTableView: UITableView!
    @IBOutlet weak var statView: UIView!
    @IBOutlet weak var chartView: ChartView!
    @IBOutlet weak var chartViewMinggu: ChartViewMinggu!
    @IBOutlet weak var chartViewBulan: ChartViewBulan!
    @IBOutlet weak var chartViewTahun: ChartViewTahun!
    @IBOutlet weak var tipsCollectionView: UICollectionView!
    @IBOutlet weak var mingguButton: UIButton!
    @IBOutlet weak var bulanButton: UIButton!
    @IBOutlet weak var tahunButton: UIButton!
    
    let dataTips = TipsData()
    let setoranData = SetoranData()
    var arrSelectRow = TipsModel(tipsImage: nil, title: "", isi: "", date: "")
    
    let thickness: CGFloat = 2.6
    var lineViewMinggu = UIView()
    var lineViewBulan = UIView()
    var lineViewTahun = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        chartViewBulan.isHidden = true
        chartViewTahun.isHidden = true
        chartView.isHidden = false
        
        setoranTableView.delegate = self
        setoranTableView.dataSource = self
        setoranTableView.register(UINib(nibName: "SetoranCell", bundle: nil), forCellReuseIdentifier: "setoranCell")
        
        tipsCollectionView.delegate = self
        tipsCollectionView.dataSource = self
        tipsCollectionView.register(UINib(nibName: "TipsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tipsCell")
    }
    
    private func play() {
        self.perform(#selector(animateViews), with: .none)
    }
    
    @objc open func animateViews() {
        chartView.play()
    }
    
    private func playMinggu() {
        self.perform(#selector(animateViewsMinggu), with: .none)
    }
    
    @objc open func animateViewsMinggu() {
        chartViewMinggu.play()
    }
    
    private func playBulan() {
        self.perform(#selector(animateViewsBulan), with: .none)
    }
    
    @objc open func animateViewsBulan() {
        chartViewBulan.play()
    }
    
    private func playTahun() {
        self.perform(#selector(animateViewsTahun), with: .none)
    }
    
    @objc open func animateViewsTahun() {
        chartViewTahun.play()
    }
    
    //MARK: - Customize UI
    private func setupUI() {
        
        self.tipsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        indikatorSaldoView.clipsToBounds = true
        indikatorSaldoView.layer.cornerRadius = 5
        indikatorSaldoView.layer.shadowColor = UIColor.black.cgColor
        indikatorSaldoView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        indikatorSaldoView.layer.shadowOpacity = 0.1
        indikatorSaldoView.layer.shadowRadius = 12
        indikatorSaldoView.layer.masksToBounds = false
        
        statView.clipsToBounds = true
        statView.layer.cornerRadius = 5
        statView.layer.shadowColor = UIColor.black.cgColor
        statView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        statView.layer.shadowOpacity = 0.1
        statView.layer.shadowRadius = 12
        statView.layer.masksToBounds = false
        
        viewDompet.clipsToBounds = true
        viewDompet.layer.cornerRadius = 5
        viewDompet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .white
        
        tabBarController?.tabBar.backgroundImage = UIImage()
        tabBarController?.tabBar.shadowImage = UIImage()
        tabBarController?.tabBar.backgroundColor = .white
        tabBarController?.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: -4.0)
        tabBarController?.tabBar.layer.shadowOpacity = 0.1
        tabBarController?.tabBar.layer.shadowRadius = 12
        
        let label = UILabel()
        label.textColor = UIColor(named: "DarkBlue")
        label.text = "Trashure"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        lineViewMinggu = UIView(frame: CGRect(x: 0, y: mingguButton.frame.size.height + thickness, width: mingguButton.frame.size.width, height: 3))
        
        lineViewBulan = UIView(frame: CGRect(x: 0, y: bulanButton.frame.size.height + thickness, width: bulanButton.frame.size.width, height: 3))
        
        lineViewTahun = UIView(frame: CGRect(x: 0, y: tahunButton.frame.size.height + thickness, width: tahunButton.frame.size.width, height: 3))
        
        lineViewMinggu.backgroundColor = UIColor(named: "green")
        
        mingguButton.addSubview(lineViewMinggu)
        
        lineViewBulan.backgroundColor = UIColor(named: "green")
        
        lineViewTahun.backgroundColor = UIColor(named: "green")
        
        lineViewMinggu.clipsToBounds = true
        lineViewMinggu.layer.cornerRadius = 1
        
        lineViewBulan.clipsToBounds = true
        lineViewBulan.layer.cornerRadius = 1
        
        lineViewTahun.clipsToBounds = true
        lineViewTahun.layer.cornerRadius = 1
    
        chartView.completionCallback = {
            self.play()
        }
        
        play()
    }
    
    @IBAction func lihatSemuaPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toSetoran", sender: self)
    }
    
    
    @IBAction func chartTypePressed(_ sender: UIButton) {
        
        switch sender {
        case mingguButton:
            self.chartViewBulan.isHidden = true
            self.chartViewTahun.isHidden = true
            self.chartView.isHidden = true
            self.chartViewMinggu.isHidden = false
            
            chartViewMinggu.completionCallback = {
                self.playMinggu()
            }
            
            playMinggu()
            
            lineViewMinggu.alpha = 1
            lineViewBulan.alpha = 0
            lineViewTahun.alpha = 0
        case bulanButton:
            
            bulanButton.addSubview(lineViewBulan)
            
            self.chartView.isHidden = true
            self.chartViewMinggu.isHidden = true
            self.chartViewBulan.isHidden = false
            self.chartViewTahun.isHidden = true

            chartViewBulan.completionCallback = {
                self.playBulan()
            }
            
            playBulan()
            
            lineViewBulan.alpha = 1
            lineViewMinggu.alpha = 0
            lineViewTahun.alpha = 0
        case tahunButton:
            
            tahunButton.addSubview(lineViewTahun)
            
            self.chartView.isHidden = true
            self.chartViewMinggu.isHidden = true
            self.chartViewBulan.isHidden = true
            self.chartViewTahun.isHidden = false
            
            chartViewTahun.completionCallback = {
                self.playTahun()
            }
            
            playTahun()
            
            lineViewTahun.alpha = 1
            lineViewMinggu.alpha = 0
            lineViewBulan.alpha = 0
        default:
            chartViewBulan.isHidden = true
            chartViewTahun.isHidden = true
            chartView.isHidden = false
            chartView.completionCallback = {
                self.play()
            }
            
            play()
            
            lineViewMinggu.alpha = 1
            lineViewBulan.alpha = 0
            lineViewTahun.alpha = 0
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setoranCell", for: indexPath) as! SetoranCell
        
        cell.idLabel.text = setoranData.data[indexPath.row].id
        cell.statusLabel.text = setoranData.data[indexPath.row].status
        cell.dateLabel.text = setoranData.data[indexPath.row].date
        
        if cell.statusLabel.text == "Selesai" {
            cell.statusLabel.textColor = UIColor(named: "green")
        }
        
        return cell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTips.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tipsCell", for: indexPath) as! TipsCollectionViewCell
        
        cell.tipsImage.image = dataTips.data[indexPath.row].tipsImage
        cell.titleLabel.text = dataTips.data[indexPath.row].title
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        self.arrSelectRow = dataTips.data[indexPath.row]
        
        performSegue(withIdentifier: "toDetailTips", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? DetailTipsViewController
        
        if segue.identifier == "toDetailTips" {
            DispatchQueue.main.async {
                controller?.arrTips = self.arrSelectRow
            }
        }
    }
}
