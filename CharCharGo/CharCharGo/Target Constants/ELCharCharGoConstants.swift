//
//  ELCharCharGoConstants.swift
//  CharCharGo
//
//  Created by Edan Lichtenstein on 11/25/17.
//  Copyright © 2017 Ruckt. All rights reserved.
//

import Foundation

struct ELCharCharGoConstants {
    
    #if SIMPSONS
    static let kCHAR_URL = "https://api.duckduckgo.com/?q=simpsons+characters&format=json"
    static let kAPP_TITLE = "Simpsons Char"
    #endif
    
    #if SEINFELD
    static let kCHAR_URL = "https://api.duckduckgo.com/?q=seinfeld+characters&format=json"
    static let kAPP_TITLE = "Seinfeld Char"
    #endif
}
