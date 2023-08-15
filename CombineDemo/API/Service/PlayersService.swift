//
//  PlayersService.swift
//  CombineDemo
//
//  Created by Michal Cichecki on 30/06/2019.
//

import Foundation
import Combine

enum ServiceError: Error {
    case url(URLError)
    case urlRequest
    case decode(String)
}

protocol PlayersServiceProtocol {
    func get() -> AnyPublisher<[Player], Error>
}

let apiKey: String = "keyW9iw7rCrEtnyWK"

final class PlayersService: PlayersServiceProtocol {
    
    func get() -> AnyPublisher<[Player], Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        
        return Future<[Player], Error> { [weak self] promise in
            dataTask = URLSession.shared.dataTask(with: URL(string: "https://api.airtable.com/v0/appKXnS9aI2go4cQj/players?api_key=keyW9iw7rCrEtnyWK")!) { (data,req, error) in
                guard let data = data else {
                    if let error = error {
                        promise(.failure(error))
                    }
                    return
                }
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    promise(.success(response.records.map {$0.fields }))
                } catch {
                    // MARK: 1. Fix the Error Method
                    print("Error")
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
