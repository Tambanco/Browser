//
//  NavBar.swift
//  Browser
//
//  Created by tambanco 🥳 on 01.06.2021.
//

import UIKit

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
