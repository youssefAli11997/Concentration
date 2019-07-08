//
//  Concentration.swift
//  Concentration
//
//  Created by Youssef Ali on 7/1/19.
//  Copyright © 2019 Youssef Ali. All rights reserved.
//

import Foundation

struct Concentration{
    
    private var indexOfOneAndOnlyOneFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    private(set) var cards = [Card]()
    
    init(numberOfPairs: Int) {
        for _ in 1...numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }

    mutating func chooseCard(at index: Int) -> [Int]? {
        var matchedPairIndices: [Int]? = nil
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index {
                // check if they match
                if cards[index] == cards[matchIndex] {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    matchedPairIndices = [index, matchIndex]
                }
                cards[index].isFaceUp = true
            }
            else {
                // no cards or 2 cards are face up
                indexOfOneAndOnlyOneFaceUpCard = index
            }
        }
        return matchedPairIndices
    }

}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
