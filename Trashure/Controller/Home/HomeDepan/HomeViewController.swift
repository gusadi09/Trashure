//
//  HomeViewController.swift
//  Trashure
//
//  Created by Gus Adi on 21/10/20.
//

import UIKit
import Charts
import FirebaseFirestore
import Kingfisher
import Firebase

class HomeViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var indikatorSaldoView: UIView!
    @IBOutlet weak var viewDompet: UIView!
    @IBOutlet weak var trashbagLabel: UILabel!
    @IBOutlet weak var connectedLabel: UILabel!
    @IBOutlet weak var levelText: UILabel!
    @IBOutlet weak var setoranTableView: UITableView!
    @IBOutlet weak var statView: UIView!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var tipsCollectionView: UICollectionView!
    @IBOutlet weak var mingguButton: UIButton!
    @IBOutlet weak var bulanButton: UIButton!
    @IBOutlet weak var tahunButton: UIButton!
    @IBOutlet weak var saldoLabel: UILabel!
    
    lazy var barChart = BarChartView()
    
    let setoranData = SetoranData()
    var arrSelectRow = TipsModel(tipsImage: "", title: "", isi: "", date: "")
    let defaults = UserDefaults.standard
    var tips : [TipsModel] = []
    let db = Firestore.firestore()
    
    let date = Date()
    var trashbagM = [Double]()
    var trashbagB = [Double]()
    var trashbagT = [Double]()
    
    var totalM = 0.0
    var totalB = 0.0
    
    let thickness: CGFloat = 2.7
    var lineViewMinggu = UIView()
    var lineViewBulan = UIView()
    var lineViewTahun = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setoranTableView.delegate = self
        setoranTableView.dataSource = self
        setoranTableView.register(UINib(nibName: "SetoranCell", bundle: nil), forCellReuseIdentifier: "setoranCell")
        
        tipsCollectionView.delegate = self
        tipsCollectionView.dataSource = self
        tipsCollectionView.register(UINib(nibName: "TipsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tipsCell")
        
        barChart.delegate = self
        
        loadTips()
    }
    
    func loadTips() {
        db.collection("tips").getDocuments { (qs, err) in
            self.tips = []
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in qs!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    let img = document.data()["pic"] as! String
                    
                    let judul = document.data()["title"] as! String
                    let isi = document.data()["isi"] as! String
                    let tanggal = document.data()["tanggal"] as! String
                    let model = TipsModel(tipsImage: img, title: judul, isi: isi, date: tanggal)
                    
                    self.tips.append(model)
                    DispatchQueue.main.async {
                        self.tipsCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    
    //MARK: - Customize UI
    private func setupUI() {
        let day = ["1", "2", "3", "4"]
        trashbagM = [8.0, 2.0, 8.0, 10.0]
        
        self.tipsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        if setoranData.data.count == 0 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 373, height: 17))
            let txt = UILabel()
            txt.textColor = UIColor(named: "DarkBlue")
            txt.text = "Upss!! Kamu belum pernah menyetorkan sampah"
            txt.font = .systemFont(ofSize: 14, weight: .regular)
            view.addSubview(txt)
            setoranTableView.addSubview(view)
        }
        
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
        
        //MARK: navigation custom
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .white
      
        let label = UILabel()
        label.textColor = UIColor(named: "DarkBlue")
        label.text = "Trashure"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.1
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        
        //MARK: Tab Bar Custom
        tabBarController?.tabBar.backgroundImage = UIImage()
        tabBarController?.tabBar.shadowImage = UIImage()
        tabBarController?.tabBar.backgroundColor = .white
        tabBarController?.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: -4.0)
        tabBarController?.tabBar.layer.shadowOpacity = 0.1
        tabBarController?.tabBar.layer.shadowRadius = 12
        
        //MARK: bottom line Chart selection
        lineViewMinggu = UIView(frame: CGRect(x: 0, y: mingguButton.frame.size.height + thickness, width: mingguButton.frame.size.width, height: 3))
        
        lineViewBulan = UIView(frame: CGRect(x: -6, y: bulanButton.frame.size.height + thickness, width: mingguButton.frame.size.width, height: 3))
        
        lineViewTahun = UIView(frame: CGRect(x: -5, y: tahunButton.frame.size.height + thickness, width: mingguButton.frame.size.width, height: 3))
        
        lineViewMinggu.backgroundColor = UIColor(named: "green")
        
        mingguButton.addSubview(lineViewMinggu)
        
        lineViewBulan.backgroundColor = UIColor(named : "green")
        
        lineViewTahun.backgroundColor = UIColor(named: "green")
        
        lineViewMinggu.clipsToBounds = true
        lineViewMinggu.layer.cornerRadius = 1
        
        lineViewBulan.clipsToBounds = true
        lineViewBulan.layer.cornerRadius = 1
        
        lineViewTahun.clipsToBounds = true
        lineViewTahun.layer.cornerRadius = 1
        
        let level = defaults.string(forKey: "level")
        let saldo = defaults.string(forKey: "saldo")
        
        levelText.text = level
        saldoLabel.text = saldo
        
        setupCharts(xVal: day, yVal: trashbagM, maxVal: 20.0, width: 0.15)
        
        var i = 0
        while i < trashbagM.count {
            let curr = trashbagM[i]
            totalM += curr
            i += 1
        }
        print("total: \(totalM)")
        
        
    }
    
    //MARK: Bar Charts
    func setupCharts(xVal: [String], yVal: [Double], maxVal: Double, width: Double) {
        barChart.frame = CGRect(x: 0, y: 0, width: self.chartView.frame.width, height: self.chartView.frame.height)
        
        let rightAxis = barChart.rightAxis
        rightAxis.axisMinimum = 0
        
        let leftAxis = barChart.leftAxis
        leftAxis.axisMinimum = 0
        
        barChart.chartDescription?.enabled = false
        
        barChart.drawBordersEnabled = false
        barChart.legend.form = .none
        
        barChart.xAxis.drawGridLinesEnabled = false
        
        barChart.xAxis.drawAxisLineEnabled = false
        barChart.leftAxis.drawAxisLineEnabled = false
        barChart.leftAxis.drawGridLinesEnabled = false
        barChart.rightAxis.enabled = false
        barChart.legend.enabled = false
        barChart.doubleTapToZoomEnabled = false
        
        barChart.xAxis.labelTextColor = UIColor(named: "DarkBlue") ?? .black
        barChart.leftAxis.labelTextColor = UIColor(named: "DarkBlue") ?? .black
        
        barChart.xAxis.labelPosition = .bottom
        
        barChart.translatesAutoresizingMaskIntoConstraints = false
        chartView.addSubview(barChart)
        barChart.topAnchor.constraint(equalTo: chartView.topAnchor).isActive = true
        barChart.bottomAnchor.constraint(equalTo: chartView.bottomAnchor).isActive = true
        barChart.leftAnchor.constraint(equalTo: chartView.leftAnchor).isActive = true
        barChart.rightAnchor.constraint(equalTo: chartView.rightAnchor).isActive = true
        barChart.heightAnchor.constraint(equalTo: chartView.heightAnchor).isActive = true
        
        barChart.leftAxis.axisMaximum = maxVal
        
        barChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        barChart.setBarChartData(xValues: xVal, yValues: yVal, barW: width)
    }

//MARK: -Action
    @IBAction func lihatSemuaPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toSetoran", sender: self)
    }
    
    
    @IBAction func chartTypePressed(_ sender: UIButton) {
        
        switch sender {
        case mingguButton:
            let day = ["1", "2", "3", "4"]
            trashbagM = [8.0, 2.0, 8.0, 10.0]
        
            setupCharts(xVal: day, yVal: trashbagM, maxVal: 20.0, width: 0.15)
            
            lineViewMinggu.alpha = 1
            lineViewBulan.alpha = 0
            lineViewTahun.alpha = 0
        case bulanButton:
            
            bulanButton.addSubview(lineViewBulan)
        
            let month = date.get(.month)
            var months = [String]()
            trashbagB = [Double]()
            
            if month < 6 && month > 1{
                months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
                trashbagB = [10.0, 18.0, 8.0, 30.0, 10.0, 18.0]
            } else {
                months = ["Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
                trashbagB = [8.0, 30.0, 23.0, 48.0, totalM, 0.0]
            }
            
            setupCharts(xVal: months, yVal: trashbagB, maxVal: 50.0, width: 0.2)
            
            lineViewBulan.alpha = 1
            lineViewMinggu.alpha = 0
            lineViewTahun.alpha = 0
        case tahunButton:
            
            tahunButton.addSubview(lineViewTahun)
        
            let year = date.get(.year)
            var years = [String]()
            trashbagT = [Double]()
            
            if year < 2023 && year > 2020{
                years = ["2020", "2021", "2022", "2023"]
                trashbagT = [10.0, 0.0, 0.0, 0.0]
            } else {
                years = ["2024", "2025", "2026", "2027"]
                trashbagT = [0.0, 0.0, 0.0, 0.0]
            }
            
            setupCharts(xVal: years, yVal: trashbagT, maxVal: 50.0, width: 0.15)
            
            lineViewTahun.alpha = 1
            lineViewMinggu.alpha = 0
            lineViewBulan.alpha = 0
        default:
            let day = ["1", "2", "3", "4"]
            trashbagM = [5.0, 11.0, 3.0, 13.0]
            
            setupCharts(xVal: day, yVal: trashbagM, maxVal: 20.0, width: 0.15)
            
            lineViewMinggu.alpha = 1
            lineViewBulan.alpha = 0
            lineViewTahun.alpha = 0
        }
    }
    
    @IBAction func pengaturanPressed(_ sender: UIBarButtonItem) {
        if sender.title == "pengaturan" {
            performSegue(withIdentifier: "toSetting", sender: self)
        } else {
            performSegue(withIdentifier: "toNotification", sender: self)
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if setoranData.data.count == 0 {
            self.setoranTableView.setEmptyMessage("Upss!! Kamu belum pernah menyetorkan sampah")
        } else {
            self.setoranTableView.restore()
        }
        
        return setoranData.data.count
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
        
        return tips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tipsCell", for: indexPath) as! TipsCollectionViewCell
       
        let url = URL(string: tips[indexPath.row].tipsImage)
        cell.tipsImage.kf.setImage(with: url)
        cell.titleLabel.text = tips[indexPath.row].title
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        self.arrSelectRow = tips[indexPath.row]
        
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

//MARK: - Extension
extension UITableView {
    func setEmptyMessage(_ message: String) {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            messageLabel.text = message
            messageLabel.textColor = UIColor(red: 196, green: 196, blue: 196, alpha: 1)
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont(name: "SF UI Display", size: 14)
            messageLabel.sizeToFit()

            self.backgroundView = messageLabel
            self.separatorStyle = .none
        }
    
    func restore() {
            self.backgroundView = nil
            self.separatorStyle = .none
    }
}

extension BarChartView {

    private class BarChartFormatter: NSObject, IAxisValueFormatter {
        
        var labels: [String] = []
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return labels[Int(value)]
        }
        
        init(labels: [String]) {
            super.init()
            self.labels = labels
        }
    }
    
    func setBarChartData(xValues: [String], yValues: [Double], barW: Double) {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<yValues.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: yValues[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries)
        let chartData = BarChartData(dataSet: chartDataSet)
        
        chartDataSet.setColor(UIColor(named: "orange") ?? .orange)
        chartDataSet.highlightEnabled = false
        chartDataSet.valueTextColor = UIColor(named: "DarkBlue") ?? .black
        
        let chartFormatter = BarChartFormatter(labels: xValues)
        let xAxis = XAxis()
        xAxis.valueFormatter = chartFormatter
        chartData.barWidth = barW
        chartData.setValueTextColor(UIColor(named: "DarkBlue") ?? .black)
        self.xAxis.valueFormatter = xAxis.valueFormatter
        self.xAxis.setLabelCount(xValues.count, force: false)
        
        self.data = chartData
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
