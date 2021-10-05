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
    case decode
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
        
        
//                return URLSession.shared.dataTaskPublisher(for: urlRequest!)
//                    .tryMap { response in
//                        return response.data
//                    }
//                    .decode(type: Records.self, decoder: JSONDecoder())
//                    .map({ records in
//                        return records.fields
//                    })
//                    .eraseToAnyPublisher()
        
        
        
        
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
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlRequest(searchTerm: String?) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.airtable.com/v0/appKXnS9aI2go4cQj"
        components.path = "/players?maxRecords=3&view=Grid%20view"
//        if let searchTerm = searchTerm, !searchTerm.isEmpty {
//            components.queryItems = [
//                URLQueryItem(name: "search", value: searchTerm)
//                URLQueryItem(name: "search", value: searchTerm)
//            ]
//        }
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        return urlRequest
    }
}
