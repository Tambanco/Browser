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

 

    // MARK: - Button configurator
extension MainViewController
{
    func  configureButtons()
    {
        let heightOfView = view.frame.height
        let widthOfView = view.frame.width
        let heightOfElement: CGFloat = 50.0
        let widthOfElement: CGFloat = widthOfView - 40.0
        let cornerRadius: CGFloat = 10
        
        let loginButton = UIButton(frame: CGRect(x: 20, y: heightOfView * 0.78, width: widthOfElement, height: heightOfElement))
        loginButton.setTitle("Go", for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.168627451, green: 0.3921568627, blue: 0.7725490196, alpha: 1)
        loginButton.layer.cornerRadius = cornerRadius
        loginButton.layer.shadowOpacity = 0.1
        loginButton.layer.shadowRadius = 3.0
        loginButton.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        loginButton.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        elementAnimator(loginButton)
        self.view.addSubview(loginButton)
    }
    
    @objc func buttonTapped(sender : UIButton)
    {
        let webVC = self.storyboard!.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        let navController = UINavigationController(rootViewController: webVC)
        navController.modalPresentationStyle = .fullScreen
        if textForRequest.contains("https://") {
            webVC.textFromMainVC = textForRequest
        } else {
            webVC.textFromMainVC = "https://\(textForRequest)"
        }
        
        self.present(navController, animated:true, completion: nil)
    }
}

    // MARK: - Dismiss keyboard methods
extension MainViewController
{
    @objc func keyboardWillShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        {
            if self.view.frame.origin.y == 0
            {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification)
    {
        if self.view.frame.origin.y != 0
        {
            self.view.frame.origin.y = 0
        }
    }
}
