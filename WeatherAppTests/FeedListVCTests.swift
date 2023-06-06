//
//  FeedListVCTests.swift
//  WeatherAppTests
//
//  Created by Mounika Gouni on 02/06/23.
//

import XCTest
@testable import WeatherApp

class FeedListVCTests: XCTestCase {

    var feedListVC: FeedListViewController!
    
    override func setUp() {
        feedListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FeedListViewController")
        feedListVC.loadViewIfNeeded()
        feedListVC.viewDidLoad()
    }
    
    override func tearDown() {
        feedListVC = nil
    }
    
    func test_feedViewController_check_allocation() {
        guard let vc = feedListVC else {
            XCTFail("FeedViewController not yet initialized")
            return
        }
        XCTAssertNotNil(vc)
    }
    
    func test_feedTableView_check_allocation() {
        XCTAssertNotNil(feedListVC.feedTableView)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
}
