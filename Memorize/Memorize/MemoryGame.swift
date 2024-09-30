//
//  MemorizeGame.swift
//  Memorize
//
//  Created by admin on 2024/9/29.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable { // CardContene：占位符，表示卡片的内容可以是任何类型，在使用时再指定具体的类型
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable {
        static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.isFaceUp == rhs.isFaceUp &&
            lhs.isMatched == rhs.isMatched &&
            lhs.content == rhs.content
        }
        
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        let content: CardContent
    }
}
