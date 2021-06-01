//
//  WebViewController.swift
//  Browser
//
//  Created by tambanco 🥳 on 01.06.2021.
//

import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate {
    
    // MARK: - Properties
    var webView: WKWebView!
    var progressView: UIProgressView!
    var textFromMainVC: String = ""
    
    
    // MARK: - Life cycle
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
        
        webView.allowsBackForwardNavigationGestures = true
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        confugureNavBar()
        confugureToolBar()
    }
    
    // MARK: - Observing
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            if webView.estimatedProgress >= 1 {
                progressView.isHidden = true
            }
        }
    }
}
