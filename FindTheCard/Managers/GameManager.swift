//
//  GameManager.swift
//  FindTheCard
//
//  Created by admin on 19.08.2023.
//

import Foundation

class GameManager {
    
    static let shared = GameManager()
    
    var points = 10
    
    var cardsToOpen = 3
    
    var gameType: gameType!
    
    var cards: [Card] = []
    
    var currentBet: Bet!
    
    func createCards() {
        for logo in cardLogo.allCases {
            for color in cardColor.allCases {
                for number in cardNumber.allCases {
                    let card = Card(logo: logo, color: color, number: number)
                    cards.append(card)
                }
            }
        }
    }
    
    func getRandomCard() -> Card? {
        if cards.isEmpty {
            createCards()
        }
        
        let randomIndex = Int.random(in: 0..<cards.count)
        let randomCard = cards.remove(at: randomIndex)
        return randomCard
    }
    
    func newGame(){
        points = 10
        cards = []
        createCards()
    }
}


enum gameType{
    case oneCard
    case threeCards
}
