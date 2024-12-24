//
//  ShapesTest.swift
//  Test1
//
//  Created by admin on 2024/9/28.
//

import SwiftUI

struct ShapesTest: View {
    var body: some View {
        // Circle()
        // Ellipse()
        // Capsule(style: .continuous) // 比如放在按钮之后
        RoundedRectangle(cornerRadius: 50.0, style: .continuous) // 比如放在文本之后
            // .fill(Color.blue)
            // .foregroundColor(Color.yellow) // 前景色
        
            // .stroke(Color.blue, style: StrokeStyle(lineWidth: 37,lineCap: .round, dash: [37]))
        
            // .trim(from: 0.11,to: 1.0)
            // .stroke(Color.blue, lineWidth: 37) // 比如用于进度条
        
            .frame(width: 300, height: 400)
    }
}

#Preview {
    ShapesTest()
}
