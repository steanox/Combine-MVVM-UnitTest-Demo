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
        //MARK: 1. Test the loading state
    }
    
    func test_playerFetchIsWorking(){
        // MARK: 2. Test the player numbers
    }

  
}

