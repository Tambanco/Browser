//
//  ViewController.swift
//  Browser
//
//  Created by tambanco 🥳 on 01.06.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    var requestTextField: UITextField!
    var textForRequest: String = ""
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            let startColor = #colorLiteral(red: 0.6078431373, green: 0.6862745098, blue: 0.8509803922, alpha: 1).cgColor
            let middleColor = #colorLiteral(red: 0.262745098, green: 0.6117647059, blue: 0.9843137255, alpha: 1).cgColor
            let endColor = #colorLiteral(red: 0.9215686275, green: 0.9568627451, blue: 0.9607843137, alpha: 1).cgColor
            gradientLayer.colors = [startColor, middleColor, endColor]
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        configureLabels()
        configureButtons()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
