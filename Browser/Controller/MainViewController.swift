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
    var gradientLayer: CAGradientLayer!
    {
        didSet
        {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            let startColor = #colorLiteral(red: 0.2078431373, green: 0.3607843137, blue: 0.4901960784, alpha: 1).cgColor
            let middleColor = #colorLiteral(red: 0.4235294118, green: 0.3568627451, blue: 0.4823529412, alpha: 1).cgColor
            let endColor = #colorLiteral(red: 0.7529411765, green: 0.4235294118, blue: 0.5176470588, alpha: 1).cgColor
            gradientLayer.colors = [startColor, middleColor, endColor]
//            gradientLayer.locations = [0.4, 0.6]
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

    // MARK: - Animation methods
extension MainViewController
{
    func elementAnimator(_ element: UIView)
    {
        element.transform = CGAffineTransform.init(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.3)
        {
            element.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        }
    }
    
    func flashButtonAnimation(_ button: UIButton)
    {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.10
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        button.layer.add(flash, forKey: nil)
    }
}


    // MARK: - Label configurator
extension MainViewController
{
    func configureLabels()
    {
        let heightOfView = view.frame.height
        let widthOfView = view.frame.width
        let heightOfElement: CGFloat = 50.0
        let widthOfElement: CGFloat = widthOfView - 40.0
        let cornerRadius: CGFloat = 10
        
        let requestTextField = UITextField(frame: CGRect(x: 20, y: heightOfView * 0.7, width: widthOfElement, height: heightOfElement))
        requestTextField.placeholder = "https://"
        requestTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: requestTextField.frame.height))
        requestTextField.leftViewMode = .always
        requestTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        requestTextField.clearButtonMode = .whileEditing
        requestTextField.autocorrectionType = .no
        requestTextField.autocapitalizationType = .none
        requestTextField.keyboardType = .asciiCapable
        requestTextField.layer.borderWidth = 2
        requestTextField.layer.cornerRadius = cornerRadius
        requestTextField.layer.borderColor = #colorLiteral(red: 0.168627451, green: 0.3921568627, blue: 0.7725490196, alpha: 1)
        requestTextField.layer.shadowOpacity = 0.1
        requestTextField.layer.shadowRadius = 3.0
        requestTextField.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        requestTextField.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        requestTextField.addTarget(self, action: #selector(self.loginTextFieldDidChange(_:)), for: .editingChanged)
        
        elementAnimator(requestTextField)
        self.view.addSubview(requestTextField)
        
    }
    
    @objc func loginTextFieldDidChange(_ textField: UITextField)
    {
        guard textField.text != "" else
        {
            return textField.layer.borderColor = #colorLiteral(red: 0.9882510304, green: 0.3398481607, blue: 0.01567719691, alpha: 1)
        }
        
        textField.layer.borderColor = #colorLiteral(red: 0.168627451, green: 0.3921568627, blue: 0.7725490196, alpha: 1)
        textForRequest = textField.text ?? "text doesn't exist"
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
