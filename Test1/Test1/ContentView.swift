//
//  ContentView.swift
//  Test1
//
//  Created by admin on 2024/9/27.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["😇", "😱", "🤩", "🤪", "🥺", "😆", "🧐", "🤗"]
    
    @State var Count: Int = 2
    
    var body: some View {
        VStack{
            ScrollView{
                Xself
            }
            Spacer()
            XCountAdjusters
        }
        .padding()
    }
    
    var Xself: some View{
        LazyVGrid(columns: [GridItem(), GridItem()]) { // 将使用尽可能少的空间
            ForEach(0..<Count, id: \.self) { index in
                MyView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(Color.yellow)
        .padding()
        .font(.largeTitle)
    }
    
    func XCountAdjuster(by offset: Int, symbol: String) -> some View{
        Button(action: {
            Count += offset
            print("press->", Count)
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(Count + offset < 1 || Count + offset > emojis.count)
    }
    
    var XCountAdjusters: some View {
        HStack{ // 将使用尽可能多的空间
            XAdder
            Spacer()
            XRemover
        }
        .foregroundStyle(Color.blue)
        .imageScale(.large)
        .font(.largeTitle) // 仅有一行代码，所以可省略 return
    }
    
    var XAdder: some View{
        XCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    var XRemover: some View{
        XCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
}

struct MyView: View {
    @State var isFaceUp: Bool = true // @State：指针，isFaceUp 在 onTapGesture 中可改变
    
    let content: String
    
    var body: some View {
        ZStack(alignment: .center){
            let base = RoundedRectangle(cornerRadius: 37)
            Group {
                base.strokeBorder(style: StrokeStyle(lineWidth: 10, dash: [11, 7]))
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundStyle(.tint)
//                    .padding(.top, -100)
                Text("🥵XYY到此一游"+content)
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.blue)
                    .padding()
                    .padding(.bottom, 30)
//                Text(content)
//                    .font(.title3)
//                    .foregroundColor(Color.pink)
//                    .padding()
//                    .padding(.bottom, -100)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            print("tapped")
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
