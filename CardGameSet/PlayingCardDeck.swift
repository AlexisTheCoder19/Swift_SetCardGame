//
//  PlayingCardDeck.swift
//  CardGameSet
//
//  Created by Alexis on 10/10/20.
//  Copyright © 2020 Cooper Studios. All rights reserved.
//

import Foundation


struct PlayingCardDeck
{
    private(set) var cards = [PlayingCard]()
    private var selectedCards = [PlayingCard]()
    
    init() {
        for shape in PlayingCard.Shape.all {
            for shade in PlayingCard.Shade.all {
                for color in PlayingCard.Color.all{
                    for numbers in PlayingCard.Number.all{
                        cards.append(PlayingCard(shape: shape, shade: shade, number: numbers, color: color))
                        
                    }
                }
                //cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
    
    mutating func draw() -> PlayingCard? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

