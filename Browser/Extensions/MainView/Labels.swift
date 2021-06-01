//
//  Labels.swift
//  Browser
//
//  Created by tambanco 🥳 on 01.06.2021.
//

import UIKit

extension MainViewController {
    
    func configureLabels() {
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
    
    @objc func loginTextFieldDidChange(_ textField: UITextField) {
        guard textField.text != "" else {
            return textField.layer.borderColor = #colorLiteral(red: 0.9882510304, green: 0.3398481607, blue: 0.01567719691, alpha: 1)
        }
        
        textField.layer.borderColor = #colorLiteral(red: 0.168627451, green: 0.3921568627, blue: 0.7725490196, alpha: 1)
        textForRequest = textField.text ?? "text doesn't exist"
    }
}
