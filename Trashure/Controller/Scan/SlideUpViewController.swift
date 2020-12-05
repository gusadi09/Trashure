//
//  SlideUpViewController.swift
//  Trashure
//
//  Created by Gus Adi on 26/11/20.
//

import UIKit

class SlideUpViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var inputButton: UIButton!
    @IBOutlet weak var conView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conView.frame(forAlignmentRect: CGRect(x: 0, y: -10, width: conView.frame.size.width, height: conView.frame.size.height))
        
        conView.layer.cornerRadius = 25

        idTextField.clipsToBounds = true
        idTextField.layer.cornerRadius = 5
        idTextField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.idTextField.frame.height))
        idTextField.leftView = paddingView
        idTextField.leftViewMode = UITextField.ViewMode.always
        
        inputButton.clipsToBounds = true
        inputButton.layer.cornerRadius = 5
        inputButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        
    }
    

    @IBAction func inputPressed(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
