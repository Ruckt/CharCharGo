//
//  ELCharacterProfile.swift
//  CharCharGo
//
//  Created by Edan Lichtenstein on 11/19/17.
//  Copyright © 2017 Ruckt. All rights reserved.
//

import Foundation
import UIKit

struct ELRelatedTopics: Codable {
    var RelatedTopics : ELCharacterProfileArray
}

struct ELCharacterProfile: Codable {
    let firstURL: String
    let description: String
    let icon: Icon
    
    let iconURL : String
    var name : String = ""
    
    enum CodingKeys: String, CodingKey {
        case firstURL = "FirstURL"
        case description = "Text"
        case icon = "Icon"
    }
    
    struct Icon : Codable {
        let Width: String
        let Height: String
        let url: String
        
        enum CodingKeys: String, CodingKey {
            case url = "URL"
            case Width
            case Height
        }
    }
}

extension ELCharacterProfile {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstURL = try values.decode(String.self, forKey: .firstURL)
        description = try values.decode(String.self, forKey: .description)
        icon = try values.decode(Icon.self, forKey: .icon)
        iconURL = icon.url
        
        if let range = description.range(of: " - ") {
            name = String(description[(description.startIndex)..<range.lowerBound])
        }
    }
}

typealias ELCharacterProfileArray = [ELCharacterProfile]

struct ELCharacterProfilelPlusImageData {
    var profile: ELCharacterProfile
    var image: UIImage?
}

typealias ELCharacterProfilelPlusImageDataArray = [ELCharacterProfilelPlusImageData]


