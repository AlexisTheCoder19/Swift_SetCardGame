//
//  CardGameSet.swift
//  CardGameSet
//
//  Created by Alexis on 10/10/20.
//  Copyright © 2020 Cooper Studios. All rights reserved.
//

import Foundation

struct CardGameSet{
    var deck = PlayingCardDeck()
    var cards: [PlayingCard] = [PlayingCard]()
    var selectedCards: [PlayingCard] = [PlayingCard]()
    var setCards: [PlayingCard] = [PlayingCard]()
    var scoreTracker = 0
    
    mutating func gameReset() {
        scoreTracker = 0
    }
    
    
    
    init(numberOfCards: Int) {
       // for _ in 1...10 {
        for _ in 0...numberOfCards {
            if let card = deck.draw() {
                cards += [card]
            }
        }
        
    }
    
    mutating public func addToDeck(){
        for _ in 0...3 {
            if let card = deck.draw() {
                cards += [card]
            }
        }
      
    }
    //function reponsible for deductin points from user if they
    //deselect the card they previusly picked
    mutating public func deSelectCard(at index:Int)->Void{
        var card = cards[index]
        if(card.isSelected == true){
            scoreTracker = scoreTracker - 1
        }
        
    }
    //function reponsible for cards that are selected
    mutating public func cardSelected(at index:Int)->Void{
        var card = cards[index]
        if !card.isSelected{
            card.isSelected = true
            card.isFaceUp = true
            if selectedCards.count < 3 {
                selectedCards.append(card)
            }
          /* if(itsASet() == false){
                print("not a Set")
            deck.cards.remove(at: selectedCards)
            
            
            }else{
                print("its a Set")
                
                
            
            }*/
            
        }else{
            card.isSelected = false
            card.isFaceUp = false
            selectedCards = selectedCards.filter({(selectedCard: PlayingCard) -> Bool in return selectedCard != card})
        }
        cards[index] = card
        
    }
    //function responsible to check if selected cards are a set
    //a teammate helped me with this part just FYI
    func itsASet() -> Bool {

        // ************* Checks for Shape Type ************
        //*************************************************
       if selectedCards[0].shape == selectedCards[1].shape
        {
           if selectedCards[0].shape != selectedCards[2].shape
            {
                return false
            }
        }
       
       else if selectedCards[1].shape == selectedCards[2].shape
        {
            return false
        }
      
       else if (selectedCards[0].shape == selectedCards[2].shape)
        
        {
            return false
        }
        
         //*****************Checks for Shade Type ************
        //****************************************************
         if selectedCards[0].shade == selectedCards[1].shade
         {
             if selectedCards[0].shade != selectedCards[2].shade
             {
                 return false
             }
         }
         
         else if selectedCards[1].shade == selectedCards[2].shade {
             
             return false
             
         }
         
         else if (selectedCards[0].shade == selectedCards[2].shade)
         {
             return false
         }
        
        //**************** Checks for color Type ********
        //************************************************
        
        if selectedCards.count != 3
        {
            return false
        }
        
        if selectedCards[0].color == selectedCards[1].color
        {
            if selectedCards[0].color != selectedCards[2].color
            {
                return false
            }
        }
        else if selectedCards[1].color == selectedCards[2].color
        {
            return false
        }
        
        else if (selectedCards[0].color == selectedCards[2].color)
        {
            return false
        }
        
        //*****************Checks for Number Type ************
        //****************************************************
        if selectedCards[0].number == selectedCards[1].number
        {
            if selectedCards[0].number != selectedCards[2].number
            {
                return false
            }
        }
        else if selectedCards[1].number == selectedCards[2].number
        {
            return false
        }
        else if (selectedCards[0].number == selectedCards[2].number)
        {
            return false
        }
         return true
    }

    
    //function responsible for creating a set and marking it on scoreboard as well as replacing cards
    mutating public func makeASet() -> Void {
        scoreTracker += 3
        for card in selectedCards {
            
            setCards.append(card)
            if let indexOfCard = cards.firstIndex(where: { $0 == card }) {
                cards[indexOfCard].isSetted = true
                if var newCard = deck.draw() {
                    newCard.isFaceUp = false
                    cards[indexOfCard] = newCard
                } else {
                    cards[indexOfCard].isFaceUp = false
                }
            }
        }
        selectedCards.removeAll()
    }
    
    mutating public func unSelectSet(){
        scoreTracker -= 4
        for card in selectedCards {
            if let indexOfCard = cards.firstIndex(where: { $0 == card }) {
                //cards[indexOfCard].isSetted = true
                cards[indexOfCard].isFaceUp = false
                cards[indexOfCard].isSelected = false
            }
        }
        selectedCards.removeAll()
        
    }
}
//this code was originally in playingCard. because it requires an extension I put this part of the code here
extension PlayingCard: Equatable{
    static func == (lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        return (lhs.shape == rhs.shape && lhs.shade == rhs.shade && lhs.color == rhs.color && lhs.number == rhs.number)
    }
}

