//
//  CameraViewController.swift
//  Trashure
//
//  Created by Gus Adi on 25/11/20.
//

import UIKit
import MTBBarcodeScanner

class CameraViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var optionsOpenedConstraint: NSLayoutConstraint!
    @IBOutlet weak var optionsVisiableConstraint: NSLayoutConstraint!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var cameraView: UIView!
    
    var scanner: MTBBarcodeScanner?
    
    let limitScan: UIImageView = UIImageView()
    let imgLimit = UIImage(named: "FrameScanning")
    
    var initialCenter = CGPoint()
    var barcode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slideView.clipsToBounds = true
        slideView.layer.cornerRadius = 5
        slideView.layer.shadowColor = UIColor.black.cgColor
        slideView.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        slideView.layer.shadowOpacity = 0.2
        slideView.layer.shadowRadius = 12
        slideView.layer.masksToBounds = false
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(type(of: self).wasDragged(gestureRecognizer:)))
        slideView.addGestureRecognizer(gesture)
        gesture.delegate = self
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 22))
        
        let title = UILabel()
        title.text = "Gunakan kamera untuk scan QR Code"
        title.textColor = .white
        title.font = UIFont(name: "SF UI Display Heavy", size: 18)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(title)
        
        slideView.addSubview(container)
        
        let inset :CGFloat = 20.0
        let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        container.fit(subView: title, .horizontallyAndVertically, with: insets)
        
        slideView.center(subView: container, orientated: .horizontallyAndVertically, withOffsets: CGPoint(x: -2, y: -155))
        
        scanner = MTBBarcodeScanner(previewView: cameraView)
        
        limitScan.image = imgLimit
        limitScan.frame.size.width = 259
        limitScan.frame.size.height = 221
        limitScan.center = cameraView.center
        cameraView.addSubview(limitScan)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        MTBBarcodeScanner.requestCameraPermission(success: { success in
            if success {
                do {
                    try self.scanner?.startScanning(resultBlock: { codes in
                        self.scanner?.scanRect = self.limitScan.frame
                        if let codes = codes {
                            for code in codes {
                                let stringValue = code.stringValue!
                                print("Found code: \(stringValue)")
                                self.barcode = stringValue
                                self.performSegue(withIdentifier: "toBerhasil", sender: self)
                            }
                        }
                    })
                } catch {
                    NSLog("Unable to start scanning")
                }
            } else {
                print("not found")
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.scanner?.stopScanning()
    }
    
    @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        let distanceFromBottom = view.frame.height - gestureRecognizer.view!.center.y
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
            optionsOpenedConstraint.isActive = false
            optionsVisiableConstraint.isActive = false
            let translation = gestureRecognizer.translation(in: self.view)
            if((distanceFromBottom - translation.y) < 100) {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
                gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
            }

        }
        if gestureRecognizer.state == UIGestureRecognizer.State.ended{
            if distanceFromBottom > 6{
                openOptionsPanel()
            }else{
                closeOptionsPanel()
            }
        }
    }
    func openOptionsPanel(){
        optionsOpenedConstraint.isActive = true
        optionsVisiableConstraint.isActive = false
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    func closeOptionsPanel(){
        optionsOpenedConstraint.isActive = false
        optionsVisiableConstraint.isActive = true
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func flashPressed(_ sender: UIButton) {
        if  ((scanner?.hasTorch()) != nil) {
            if scanner?.torchMode != MTBTorchMode.off {
                flashButton.setImage(UIImage(named: "FlashOff"), for: .normal)
                scanner?.toggleTorch()
            } else {
                flashButton.setImage(UIImage(named: "FlashOn"), for: .normal)
                scanner?.toggleTorch()
            }
        } else {
            let alert = UIAlertController(title: "not have torch", message: "not have torch", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func galleryPressed(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as? BerhasilViewController
        
        if segue.identifier == "toBerhasil" {
            dest?.barcodeValue = self.barcode
        }
    }
}

//MARK: - Extension
enum FitOrientation {
    case horizontally
    case vertically
    case horizontallyAndVertically
}

extension UIView {

    func center(subView view:UIView, orientated orientation:FitOrientation = .horizontallyAndVertically) {
        center(subView: view, orientated: orientation, withOffsets: CGPoint.zero)

    }
  
    func center(subView view:UIView, orientated orientation:FitOrientation = .horizontallyAndVertically, withOffsets offset:CGPoint) {
        if view.superview != self {
            self.addSubview(view)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        if orientation == .horizontally || orientation == .horizontallyAndVertically {
            let constraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: view.superview!, attribute: .centerX, multiplier: 1.0, constant: offset.x)
            addConstraint(constraint)
        }
        
        if orientation == .vertically || orientation == .horizontallyAndVertically {
            let constraint = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: view.superview!, attribute: .centerY, multiplier: 1.0, constant: offset.y)
            addConstraint(constraint)
        }
    }

    func fit(subView view:UIView, _ orientation:FitOrientation = .horizontallyAndVertically, with padding:UIEdgeInsets = UIEdgeInsets.zero) {
        if view.superview != self {
            self.addSubview(view)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if orientation == .horizontally || orientation == .horizontallyAndVertically {
             self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding.left)-[subview]-\(padding.right)-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": view]))
        }
        
        if orientation == .vertically || orientation == .horizontallyAndVertically {
             self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(padding.top)-[subview]-\(padding.bottom)-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": view]))
        }
    }
}
