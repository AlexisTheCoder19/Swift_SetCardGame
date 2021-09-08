//
//  PlayingCard.swift
//  CardGameSet
//
//  Created by Alexis on 10/10/20.
//  Copyright © 2020 Cooper Studios. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible{
    
    /*static func == (lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        return (lhs.shape == rhs.shape && lhs.shade == rhs.shade && lhs.color == rhs.color && lhs.number == rhs.number)
    }*/
    
    var description: String{
        return "\(shape)\(shade)\(color)\(number)"
    }
    
    var shape: Shape?
    var shade: Shade?
    var color: Color?
    var number: Number?
    var isFaceUp: Bool
    var isSelected: Bool
    var isSetted: Bool
    
    public enum Shape: String, CustomStringConvertible{
        var description: String{return rawValue}
        
        case triangle = "▲"
        case circle = "●"
        case square = "■"
        
        static var all = [Shape.triangle, .circle, .square]
        
        
    }
   public enum Shade:String, CustomStringConvertible{
        var description: String{return rawValue}
        
        case Fill = "Fill"
        case notFill = "notFill"
        case striped = "striped"
        
        static var all = [Shade.Fill, .notFill, .striped]
        
        
    }
    public enum Color:String, CustomStringConvertible{
        var description: String{return rawValue}
        case red = "red"
        case purple = "purple"
        case green = "green"
        
        static var all = [Color.red, .purple, .green]
        
    }
    public enum Number: Int{
        
        case one = 1
        case two = 2
        case three = 3
        
        static var all = [Number.one, .two, .three]
        
    }
    public init(shape: Shape, shade: Shade, number: Number, color: Color) {
        
        self.shape = shape;
        self.shade = shade;
        self.number = number;
        self.color = color;
        self.isSelected = false
        self.isFaceUp = false
        self.isSetted = false
    }
    
    
    
}
