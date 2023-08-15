//
//  PlayerServicesTest.swift
//  CombineDemoTests
//
//  Created by octavianus on 15/08/23.
//  Copyright © 2023 codeuqest. All rights reserved.
//

@testable import CombineDemo
import XCTest
import Combine


final class PlayerServicesTest: XCTestCase {

   let services = PlayersService()
    private var cancellables: Set<AnyCancellable> = []
    
    func test_NetworkIsNotError(){
        //MARK: 1. Test the networking

    }



}
