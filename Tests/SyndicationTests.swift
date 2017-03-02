//
//  SyndicationTests.swift
//
//  Copyright (c) 2016 Nuno Manuel Dias
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import XCTest
import FeedParser

class SyndicationTests: BaseTestCase {
    
    func testSyndication() {

        // Given
        let URL = fileURL("Syndication", type: "xml")
        let parser = FeedParser(URL: URL)!
        
        // When
        parser.parse { (result) in
            
            let feed = result.rssFeed
            
            // Then
            XCTAssertNotNil(feed)
            XCTAssertEqual(feed?.syndication?.syUpdatePeriod , SyndicationUpdatePeriod.Hourly)
            XCTAssertEqual(feed?.syndication?.syUpdateFrequency , Int(2))
            XCTAssertNotNil(feed?.syndication?.syUpdateBase)

        }
        
    }
    
    func testSyndicationParsingPerformance() {
        
        self.measure {
            
            // Given
            let expectation = self.expectation(withDescription: "Syndication Parsing Performance")
            let URL = self.fileURL("Syndication", type: "xml")
            let parser = FeedParser(URL: URL)!
            
            // When
            parser.parse({ (result) in
                
                // Then
                expectation.fulfill()
                
            })

            self.waitForExpectations(withTimeout: self.timeout, handler: nil)
            
        }
        
    }
    
}
