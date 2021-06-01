//
//  ViewController.swift
//  Browser
//
//  Created by tambanco 🥳 on 01.06.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var requestTextField: UITextField!
    var textForRequest: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        requestTextField.layer.borderColor = #colorLiteral(red: 0.3333333333, green: 0.631372549, blue: 0.537254902, alpha: 1)
        requestTextField.layer.shadowOpacity = 1
        requestTextField.layer.shadowRadius = 4.0
        requestTextField.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
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
        
        textField.layer.borderColor = #colorLiteral(red: 0.3333333333, green: 0.631372549, blue: 0.537254902, alpha: 1)
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
        loginButton.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.631372549, blue: 0.537254902, alpha: 1)
        loginButton.layer.cornerRadius = cornerRadius
        loginButton.layer.shadowOpacity = 1
        loginButton.layer.shadowRadius = 4.0
        loginButton.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
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
