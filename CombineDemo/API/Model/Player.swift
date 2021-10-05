//
//  Player.swift
//  CombineDemo
//
//  Created by Michal Cichecki on 30/06/2019.
//

import Foundation

struct Response: Codable{
    var records: [PlayerRecord]
}

struct PlayerRecord: Codable{
    var id: String
    var fields: Player
    var createdTime: String
}

struct Player: Codable, Hashable, Equatable{
    
    
    var firstName: String
    var lastName: String
    var team: String?
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.firstName == rhs.firstName
    }

  
}




