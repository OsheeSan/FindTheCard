//
//  Card.swift
//  FindTheCard
//
//  Created by admin on 19.08.2023.
//

import Foundation

class Card {
    
    var logo: cardLogo
    var color: cardColor
    var number: cardNumber
    
    init(logo: cardLogo, color: cardColor, number: cardNumber) {
        self.logo = logo
        self.color = color
        self.number = number
    }
    
    func imageName() -> String {
        return "\(self.color.rawValue)\(self.logo.rawValue)\(self.number.rawValue)"
    }
}
