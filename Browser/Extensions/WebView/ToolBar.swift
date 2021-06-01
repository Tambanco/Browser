//
//  ToolBar.swift
//  Browser
//
//  Created by tambanco 🥳 on 01.06.2021.
//

import UIKit

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
