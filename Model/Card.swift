//
//  Card.swift
//  Concentration
//
//  Created by Owner on 7/1/19.
//  Copyright © 2019 Owner. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    var hashValue: Int { return identifier }
    
    private static var cardCount = 0
    
    init() {
        identifier = Card.getUniqueIdentifier()
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private static func getUniqueIdentifier() -> Int{
        cardCount += 1
        return cardCount
    }
    
}
