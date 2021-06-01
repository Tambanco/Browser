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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            if webView.estimatedProgress >= 1 {
                progressView.isHidden = true
            }
        }
    }
}

    // MARK: - NavBar configurator
extension WebViewController {
    func confugureNavBar() {
        self.navigationController?.hidesBarsOnSwipe = true
        
        let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
        self.navigationItem.rightBarButtonItem  = refreshBarButtonItem
        
        let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        self.navigationItem.leftBarButtonItem  = doneBarButtonItem
    }
    
    @objc func refreshButtonTapped() {
        webView.reload()
    }
    
    @objc func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

    // MARK: - ToolBar configurator
extension WebViewController {
    func confugureToolBar() {
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let chevronLeft = UIImage(systemName: "chevron.left")
        let chevronRight = UIImage(systemName: "chevron.right")
        let backButton = UIBarButtonItem(image: chevronLeft, style: .plain, target: webView, action: #selector(webView!.goBack))
        let forwardButton = UIBarButtonItem(image: chevronRight, style: .plain, target: webView, action: #selector(webView!.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [backButton, spacer, progressButton, spacer, forwardButton]
        navigationController?.isToolbarHidden = false
    }
}

