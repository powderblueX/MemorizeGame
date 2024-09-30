//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by admin on 2024/9/29.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙", "🙀", "👹", "😱", "☠️", "🍭"] // 无 static 则报错：emojis 和 model 的初始化顺序无法确定
    
//    private var model: MemoryGame<String> = MemoryGame(numberOfPairsOfCards: 4) {
//        emojis[$0]
//    }
    
    private static func createMemoryGame () -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: emojis.count) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    @Published private var model = createMemoryGame() // @Published make sth change happen
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    // MARK: -Intents
    
    func shuffle() {
        model.shuffle()
    }
}
