//
//  ELCharacterProfile.swift
//  CharCharGo
//
//  Created by Edan Lichtenstein on 11/19/17.
//  Copyright © 2017 Ruckt. All rights reserved.
//

import Foundation

struct ELRelatedTopics: Codable {
    var RelatedTopics : ELCharacterProfileArray
}

struct ELCharacterProfile: Codable {
    let firstURL: String
    let description: String
    let icon: Icon
    
    enum CodingKeys: String, CodingKey {
        case firstURL = "FirstURL"
        case description = "Text"
        case icon = "Icon"
    }
    
    struct Icon : Codable {
        let Width: String
        let Height: String
        let iconURL: String
        
        enum CodingKeys: String, CodingKey {
            case iconURL = "URL"
            case Width
            case Height
        }
    }
}

typealias ELCharacterProfileArray = [ELCharacterProfile]

