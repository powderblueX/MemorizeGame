//
//  ColorsTest.swift
//  Test1
//
//  Created by admin on 2024/9/28.
//

import SwiftUI

struct ColorsTest: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(Color.primary)
            .frame(width: 300, height: 200)
            
    }
}

#Preview {
    ColorsTest()
}
