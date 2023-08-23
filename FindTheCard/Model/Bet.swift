//
//  Bet.swift
//  FindTheCard
//
//  Created by admin on 22.08.2023.
//

import Foundation

class Bet {
    
    static var shared = Bet()
    
    var logo: cardLogo?
    var logoBet: Int
    var number: cardNumber?
    var numberBet: Int
    var color: cardColor?
    var colorBet: Int
    
    init(logo: cardLogo? = nil, logoBet: Int = 0, number: cardNumber? = nil, numberBet: Int = 0, color: cardColor? = nil, colorBet: Int = 0) {
        self.logo = logo
        self.logoBet = logoBet
        self.number = number
        self.numberBet = numberBet
        self.color = color
        self.colorBet = colorBet
        GameManager.shared.points -= logoBet + numberBet + colorBet
    }
    
    func checkWin(card1: Card?, card2: Card? = nil, card3: Card? = nil) -> Int {
        print("BET FOR LOGO: \(logoBet)")
        print("BET FOR NUMBER: \(numberBet)")
        print("BET FOR COLOR: \(colorBet)")
        print("CARD1 : \(card1?.imageName())")
        print("CARD2 : \(card2?.imageName())")
        print("CARD3 : \(card3?.imageName())")
        var res = -(logoBet + numberBet + colorBet)
        switch GameManager.shared.gameType {
        case .threeCards:
            if logo != nil {
                var count = 0
                if logo == card1!.logo {
                    print("CARD1 logo similar")
                    count += 1
                }
                if logo == card2!.logo {
                    print("CARD2 logo similar")
                    count += 1
                }
                if logo == card3!.logo {
                    print("CARD3 logo similar")
                    count += 1
                }
                logoBet *= count
                res += logoBet
                print("logo res: \(res)")
                GameManager.shared.points += logoBet
            }
            if number != nil {
                var count = 0
                if number == card1!.number {
                    count += 1
                    print("CARD1 num similar")
                }
                if number == card2!.number {
                    count += 1
                    print("CARD2 num similar")
                }
                if number == card3!.number {
                    count += 1
                    print("CARD3 num similar")
                }
                numberBet *= count
                res += numberBet
                print("num res: \(res)")
                GameManager.shared.points += numberBet
            }
            if color != nil {
                var count = 0
                if color == card1!.color {
                    count += 1
                    print("CARD1 color similar")
                }
                if color == card2!.color {
                    count += 1
                    print("CARD2 color similar")
                }
                if color == card3!.color {
                    count += 1
                    print("CARD3 color similar")
                }
                colorBet *= count
                res += colorBet
                print("num res: \(res)")
                GameManager.shared.points +=  colorBet
            }
        case .oneCard:
            if logo != nil {
                if logo == card1!.logo {
                    logoBet *= 2
                    res += logoBet
                    GameManager.shared.points += logoBet
                }
            }
            if number != nil {
                if number == card1!.number {
                    numberBet *= 2
                    res += numberBet
                    GameManager.shared.points += numberBet
                }
            }
            if color != nil {
                if color == card1!.color {
                    colorBet *= 2
                    res += colorBet
                    GameManager.shared.points += colorBet
                }
            }
        default:
            break
        }
        print("RESULTAT : \(res)")
        return res
    }
}
