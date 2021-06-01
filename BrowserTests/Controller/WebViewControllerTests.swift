//
//  WebViewControllerTests.swift
//  BrowserTests
//
//  Created by tambanco 🥳 on 01.06.2021.
//

import XCTest
@testable import Browser

class WebViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTableViewNotNilWhenViewIsLoaded() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: WebViewController.self))
        let sut = vc as! WebViewController
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.view)
    }
}
