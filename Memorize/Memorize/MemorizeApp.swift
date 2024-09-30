//
//  MemorizeApp.swift
//  Memorize
//
//  Created by admin on 2024/9/29.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        @StateObject var game = EmojiMemoryGame()
        
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
