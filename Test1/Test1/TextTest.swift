//
//  TextTest.swift
//  Test1
//
//  Created by admin on 2024/9/28.
//

import SwiftUI

struct TextTest: View {
    var body: some View {
        Text("Hello, World! Hello, World! Hello, World! Hello, World! Hello, World!  Hello, World!".uppercased())
//            .font(.title)
//            .bold()
//            .underline(true, color: Color.yellow)
//            .italic()
//            .strikethrough(true, color: Color.blue)
            .font(.system(size: 24, weight: .semibold, design: .serif))
            .foregroundColor(Color.blue)
            .multilineTextAlignment(.trailing)
            .baselineOffset(-10.0)
            .kerning(6)
            .frame(width: 200, height: 1200, alignment: .leading)
    }
}

#Preview {
    TextTest()
}
