//
//  ContentView.swift
//  Memorize
//
//  Created by admin on 2024/9/29.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            
        }.padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundStyle(Color.blue)
        .padding()
    }
    
    struct CardView: View {
        let card: MemoryGame<String>.Card
       
        init(_ card: MemoryGame<String>.Card) {
            self.card = card
        }
        
        var body: some View {
            ZStack(alignment: .center){
                let base = RoundedRectangle(cornerRadius: 37)
                Group {
                    base.strokeBorder(style: StrokeStyle(lineWidth: 3))
                    Text(card.content)
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1, contentMode: .fit)
                }
                .opacity(card.isFaceUp ? 1 : 0)
                base.fill()
                    .opacity(card.isFaceUp ? 0 : 1)
            }
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
