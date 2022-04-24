//
//  SaidSoTests.swift
//  SaidSoTests
//
//  Created by Michael Tran on 21/4/2022.
//

import XCTest
@testable import SaidSo

class SaidSoTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        NetworkModel.getRequest(theUrl: "https://quotes.rest/qod.json?category=inspire"){jsonStr in
            print(jsonStr);
        }
        }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testResultsFail()  throws {
        print("empty str");
        let results = QuoteCore.parseJson(jsonString: "");
        XCTAssertNotEqual(results.quote, "", "Parse result must Not empty");
    }


    func testResultsPass() throws {
        print(" not empty str");
        
        let results = QuoteCore.parseJson(jsonString: json);
        XCTAssertNotEqual(results.quote, "", "Parse result is Not empty");
        }
    
    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
    
           
        }
    }
    
}
