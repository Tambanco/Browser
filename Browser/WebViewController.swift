//
//  WebViewController.swift
//  Browser
//
//  Created by tambanco 🥳 on 01.06.2021.
//

import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate {
    
    var textFromMainVC: String = ""
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard textFromMainVC != "" else {
            return print("Empty request")
        }
        let myURL = URL(string: textFromMainVC)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
