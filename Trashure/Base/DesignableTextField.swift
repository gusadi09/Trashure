//
//  DesignableTextField.swift
//  Trashure
//
//  Created by Gus Adi on 18/10/20.
//

import UIKit

class DesignableTextField: UITextField {

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
            var textRect = super.leftViewRect(forBounds: bounds)
            textRect.origin.x += leftPadding
            return textRect
        }
        
        @IBInspectable var leftImage: UIImage? {
            didSet {
                updateView()
            }
        }
        
        @IBInspectable var leftPadding: CGFloat = 0
        
        func updateView() {
            if let image = leftImage {
                leftViewMode = UITextField.ViewMode.always
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                imageView.contentMode = .scaleAspectFit
                imageView.image = image
                leftView = imageView
            } else {
                leftViewMode = UITextField.ViewMode.never
                leftView = nil
            }
        }
}
