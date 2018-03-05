//
//  SimpsonsCharactersTests.swift
//  SimpsonsCharactersTests
//
//  Created by Edan Lichtenstein on 3/4/18.
//  Copyright © 2018 Ruckt. All rights reserved.
//

import XCTest

class SimpsonsCharactersTests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testCallToDuckDuckGoCompletes() {
        let url = URL(string: "https://api.duckduckgo.com/?q=simpsons+characters&format=json")

        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
