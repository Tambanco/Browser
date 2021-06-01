//
//  Buttons.swift
//  Browser
//
//  Created by tambanco 🥳 on 01.06.2021.
//

import UIKit

extension MainViewController {
    
    func  configureButtons() {
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
    
    @objc func buttonTapped(sender : UIButton) {
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
