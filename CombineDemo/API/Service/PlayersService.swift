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
                } catch let DecodingError.dataCorrupted(context) {
                    let errMessage = "Error data Corrupted: \(context.debugDescription)"
                    promise(.failure(ServiceError.decode(errMessage)))
                } catch let DecodingError.keyNotFound(key, context) {
                    let errMessage = "Error key not found: \(key) \(context.debugDescription)"
                    promise(.failure(ServiceError.decode(errMessage)))
                } catch let DecodingError.valueNotFound(value, context) {
                    let errMessage = "Error Value Not Found: \(value) \(context.debugDescription)"
                    promise(.failure(ServiceError.decode(errMessage)))
                } catch let DecodingError.typeMismatch(type, context)  {
                    let errMessage = "Erro Coding Path Mismatch: \(type) \(context.debugDescription)"
                    promise(.failure(ServiceError.decode(errMessage)))
                } catch {
                    promise(.failure(ServiceError.decode("Unknown Error")))
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
