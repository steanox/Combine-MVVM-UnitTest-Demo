//
//  CombineDemoTests.swift
//  CombineDemoTests
//
//  Created by Michal Cichecki on 04/07/2019.
//

@testable import CombineDemo
import XCTest
import Combine

class LoginViewModelTests: XCTestCase {

    private var subject: ListViewModel!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        subject = ListViewModel()
        
    }
    
    override func tearDown() {
        cancellables.forEach { $0.cancel() }
        subject = nil
        
        super.tearDown()
    }
    
    func test_loadingStateWorking(){
        //condition
        subject.fetchPlayers()
        //Given
        let expected: ListViewModelState = .loading
        
        //Output
        XCTAssertEqual(expected, subject.state)
    }
    
    func test_finishedloadingStateWorking(){
        //condition
        subject.fetchPlayers()
        let exp = expectation(description: "Fetch Data for 5 seconds")
        XCTWaiter.wait(for: [exp], timeout: 5.0)
         
        //Given
        let expected: ListViewModelState = .finishedLoading
        
        //Output
        XCTAssertEqual(expected, subject.state)
    }
  
}

