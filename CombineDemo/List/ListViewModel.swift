//
//  ListViewModel.swift
//  CombineDemo
//
//  Created by Michal Cichecki on 30/06/2019.
//

import Foundation
import Combine

enum ListViewModelState: Equatable {
    case loading
    case finishedLoading
    case error
}


final class ListViewModel {
    enum Section { case players }
    
    //MARK: 1. Make the variable to become a publisher
    var searchText: String = ""
    private(set) var players: [Player] = []
    private(set) var state: ListViewModelState = .loading
    
    private var originalData: [Player] = []
    private let playersService: PlayersServiceProtocol
    
    // MARK: 4. Create the cancelables properties
    
    init(playersService: PlayersServiceProtocol = PlayersService()) {
        self.playersService = playersService
        
        //MARK: 3. Subscribe to the search text
    }
    
    
    
    func fetchPlayers() {
        // MARK: 2. Change the loading state and observe the player fetching
    }
}
