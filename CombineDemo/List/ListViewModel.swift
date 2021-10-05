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
    
    
    @Published var searchText: String = ""
    @Published private(set) var players: [Player] = []
    @Published private(set) var state: ListViewModelState = .loading
    private var originalData: [Player] = []
    
    private let playersService: PlayersServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(playersService: PlayersServiceProtocol = PlayersService()) {
        self.playersService = playersService
        
        $searchText
            .sink { [weak self] searchText in
                guard let self = self else  { return }
                if searchText.isEmpty { self.players = self.originalData }
                else { self.players = self.originalData.filter { $0.firstName.contains(self.searchText) } }
            }
            .store(in: &bindings)
    }
    
    
    
    func fetchPlayers() {
        state = .loading
        playersService
            .get()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                    case .failure: self?.state = .error
                    case .finished: self?.state = .finishedLoading
                }
            }, receiveValue: { players in
                self.players = players
                self.originalData = players
            })
            .store(in: &bindings)
    }
}
