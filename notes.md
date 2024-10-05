# MemorizeGame

2024.10.1

- @escaping：用于标记闭包参数，表示这个闭包在函数返回之后仍然可能被执行。也就是说，闭包逃逸出了函数的作用域。常用于异步操作或回调。
```swift
func performTask(completion: @escaping () -> Void) {
    print("Task started")
    
    // 模拟异步任务
    DispatchQueue.global().async {
        // 异步任务完成后调用闭包
        completion()
    }
} // completion 是一个逃逸闭包，因为它并不会在 performTask 函数返回之前立即执行，而是在异步任务完成后执行。因此必须使用 @escaping 来标记这个闭包。

performTask {
    print("Task completed")
}
```


cards.firstIndex(where:) 是 Swift 标准库中数组 (Array) 的一个方法，用来查找数组中第一个满足指定条件的元素的索引。



extension Array：这是一个 Swift 扩展，用来为已有类型 Array 添加新的功能。通过扩展，你可以向现有类型添加新的方法、计算属性等，而不需要修改原类型定义。

```swift
let array1 = [42]
let array2 = [1, 2, 3]
let array3: [Int] = []

print(array1.only) // 输出：Optional(42)，数组中有且只有一个元素
print(array2.only) // 输出：nil，数组中有多个元素
print(array3.only) // 输出：nil，数组为空

extension Array { // Array 类型创建的一个扩展
    var only: Element? { // 提供了一个名为 only 的计算属性
        count == 1 ? first : nil // 用来在数组中只有一个元素时，返回该元素
    }
}
```



2024.10.5

### HStack（水平堆叠）

HStack 是一个水平堆叠的容器，按水平顺序排列其子视图。

### VStack（垂直堆叠）

VStack 是一个垂直堆叠的容器，按垂直顺序排列子视图。

### LazyHStack（懒加载水平堆叠）

LazyHStack 是 HStack 的懒加载版本，只有在需要时才会创建和布局视图，适用于处理大量视图的情况。

```swift
LazyHStack {
    ForEach(0..<1000) { index in
        Text("Item \(index)")
    }
}
```

### LazyVStack（懒加载垂直堆叠）

LazyVStack 是 VStack 的懒加载版本，适合大规模视图列表的垂直布局。

```swift
LazyVStack {
    ForEach(0..<1000) { index in
        Text("Item \(index)")
    }
}
```

### Grid（网格）

Grid 允许创建一个结构化的网格布局，按行和列排列子视图。

```swift
Grid {
    GridRow {
        Text("Row 1, Col 1")
        Text("Row 1, Col 2")
    }
    GridRow {
        Text("Row 2, Col 1")
        Text("Row 2, Col 2")
    }
}
```

### LazyHGrid（懒加载水平网格）

LazyHGrid 是水平布局的懒加载网格。

```swift
LazyHGrid(rows: [GridItem(.fixed(50)), GridItem(.fixed(50))]) {
    ForEach(0..<10) { index in
        Text("Item \(index)")
    }
}
```

### LazyVGrid（懒加载垂直网格）

LazyVGrid 是垂直布局的懒加载网格。

```swift
LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
    ForEach(0..<100) { index in
        Text("Item \(index)")
    }
}
```

### ZStack（层叠堆叠）

ZStack 让视图在 Z 轴上堆叠，前面的视图会覆盖后面的视图。

```swift
ZStack {
    Image(systemName: "circle")
    Text("Overlay Text")
} // Text 会在 Image 之上显示。
```

### ScrollView（滚动视图）

ScrollView 允许内容超出屏幕时滚动，可以是水平或垂直滚动。

```swift
ScrollView(.vertical) {
    VStack {
        ForEach(0..<50) { index in
            Text("Item \(index)")
        }
    }
}
```

### ViewThatFits（适配视图）

ViewThatFits 允许在多个视图中选择一个最合适的来显示。

```swift
ViewThatFits {
    Text("Shorter version")
    Text("A very long version of the text that will not fit")
}
```

### .overlay modifier（覆盖修饰符）

.overlay 在视图上覆盖另一个视图，通常用来叠加额外信息或修饰。

```swift
Text("Hello World")
    .overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.blue, lineWidth: 2)
    )
```


### .fit

.fit是指保持原始比例，并尽可能地将内容放入容器中，不剪裁。图片会被缩放到足以完全适应容器的边界，但不会拉伸或填满整个容器，任何一边可能会有空白空间。

```swift
Image("example-image")
    .resizable()
    .aspectRatio(contentMode: .fit)
    .frame(width: 200, height: 200)
```

### .fill

.fit是指保持原始比例，同时将图片拉伸或裁剪，使其填满整个容器。这意味着图片可能会被剪裁掉一些部分，以确保容器的边界都被填满。

```swift
Image("example-image")
    .resizable()
    .aspectRatio(contentMode: .fill)
    .frame(width: 200, height: 200)
```


### GeomotryReader

GeometryReader 是一个容器视图，允许访问并响应其子视图的几何信息，如大小和位置。通过 GeometryReader，可获得容器的尺寸信息，动态调整子视图的布局和尺寸。

- 宽度和高度
- 位置和坐标
- 全局坐标系中的位置信息

```swift
GeometryReader { geometry in
    VStack {
        Text("Width: \(geometry.size.width)")
        Text("Height: \(geometry.size.height)")
        Text("X: \(geometry.frame(in: .local).origin.x)")
        Text("Y: \(geometry.frame(in: .local).origin.y)")
    }
    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.5)
    .background(Color.blue)
    // 蓝色的 VStack 将根据父容器（300x300 的灰色背景）的大小，动态调整其宽高为 80% 和 50%
}
.frame(width: 300, height: 300)
.background(Color.gray)
```

#### 几何坐标系

GeometryReader 提供两种不同的坐标系：
- .local：相对于父视图的坐标系。
- .global：相对于整个屏幕的全局坐标系。

```swift
geometry.frame(in: .local)
geometry.frame(in: .global)
```

#### 自适应布局应用

GeometryReader 特别适合处理响应式布局，适应不同设备的屏幕尺寸。

#### 注意事项

GeometryReader 会占据所有可用的空间。为了限制其尺寸，可以使用 .frame 修饰符来调整 GeometryReader 所占的空间。

```swift
GeometryReader { geometry in
    Text("Dynamic size text")
        .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
}
.frame(width: 200, height: 200)
```

#### 总体示例

```swift
struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                // 显示宽度和高度
                Text("Width: \(geometry.size.width)")
                    .font(.headline)
                Text("Height: \(geometry.size.height)")
                    .font(.headline)
                
                // 显示在本地坐标系中的位置 (相对于父视图)
                Text("Local X: \(geometry.frame(in: .local).origin.x)")
                    .font(.subheadline)
                Text("Local Y: \(geometry.frame(in: .local).origin.y)")
                    .font(.subheadline)
                
                // 显示在全局坐标系中的位置 (相对于屏幕)
                Text("Global X: \(geometry.frame(in: .global).origin.x)")
                    .font(.subheadline)
                Text("Global Y: \(geometry.frame(in: .global).origin.y)")
                    .font(.subheadline)
                
                // 添加一个视图并动态调整其大小和位置
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.25)
                    .overlay(
                        Text("50% Width, 25% Height")
                            .foregroundColor(.white)
                    )
            }
            .padding()
            .background(Color.gray.opacity(0.2))
        }
        .frame(width: 300, height: 400)
        .background(Color.yellow.opacity(0.5))
    }
}
```
