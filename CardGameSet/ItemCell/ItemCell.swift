//
//  ItemCell.swift
//  CardGameSet
//
//  Created by Alexis on 10/30/20.
//  Copyright © 2020 Cooper Studios. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    static let identifier = "ItemCell"
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var buttonText: UIButton!
    private var game : CardGameSet?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        game = CardGameSet(numberOfCards: 12 )
       // updateNib()
    }
    
    func updateNib(){
       /* if var setGame = game{
            let cards = setGame.cards
            let card = cards.count
            let colorNShade = getColorNShade(card: card)
            let shape = getShape(card: card)
            let attributedString = NSAttributedString(
                string: shape, attributes: colorNShade)
        }
 */
        
    }
    
    func configure(text: NSAttributedString ){
        //self.textLabel.text = text
        //self.buttonText.setTitle(text, for: UIControl.State.normal)
        self.buttonText.setAttributedTitle(text, for: UIControl.State.normal)
        
        
    }
    func configureString(text: String){
        self.buttonText.setTitle(text, for: UIControl.State.normal)
        
    }
    static func nib() -> UINib{
        return UINib(nibName: "ItemCell", bundle: nil)
    }
    private func getColorNShade(card: PlayingCard) ->
           [NSAttributedString.Key: Any] {
           var defaulColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
           var attributes: [NSAttributedString.Key: Any] = [
               .foregroundColor: defaulColor,
           ]
           if let cardColor = card.color {
               switch cardColor {
               case .red:
                   defaulColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
                   attributes[.foregroundColor] = defaulColor
               case .purple:
                   defaulColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
                   attributes[.foregroundColor] = defaulColor
               case .green:
                   defaulColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                   attributes[.foregroundColor] = defaulColor
               }
           }
           if let cardShade = card.shade {
               switch cardShade {
               case .Fill:
                   attributes[.strokeWidth] = 0
               case .notFill:
                   attributes[.strokeWidth] = 8.0
                   attributes[.strokeColor] = defaulColor
               case .striped:
                   attributes[.strokeWidth] = 8.0
                   attributes[.strokeColor] = defaulColor
                   attributes[.strikethroughStyle] = 2.0
               }
           }
           return attributes
       }
    
    //gets shape atrributes
    private func getShape(card: PlayingCard) -> String {
        var textContent = ""
        if let cardNumber = card.number {
            switch cardNumber {
            case .one:
                if let cardSymbol = card.shape {
                    textContent = String(repeating: cardSymbol.description,
                                         count: 1)
                    
                }
            case .two:
                if let cardSymbol = card.shape {
                    textContent = String(repeating: cardSymbol.description,
                                         count: 2)
                }
            case .three:
                if let cardSymbol = card.shape {
                    textContent = String(repeating: cardSymbol.description,
                                         count: 3)
                }
            }
        }
        return textContent
    }


}
