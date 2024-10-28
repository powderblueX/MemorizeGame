## MemorizeGame

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

## View

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



2024.10.28

## 多线程

### Sync Async Serial Concurrent

1. 同步(Sync)：同步方法或同步代码块在同一时间只能被一个线程执行。其他线程试图访问同步代码时，会被阻塞，直到同步代码执行完毕。
2. 异步(Async)：异步方法或代码块在执行时，不会阻塞当前线程。相反，它会将任务委托给另一个线程来执行，然后立即返回到调用者。
3. 串行(Serial)：串行执行意味着一个任务接一个任务执行，每个任务必须等待前一个任务完成。
4. 并发(Concurrent)：并发执行意味着多个任务可以在同一时间执行，可能是同一个CPU核心内的多任务处理，也可能是多个CPU核心或者分布式系统中的任务分配。

### iOS中多线程技术

1. NSThread
2. GCD(Grand Central DIspatch)
3. NSOperation/NSOperationQueue

注：iOS 多线程开发众多使用队列来管理而非自己创建 NSThread

#### GCD

1. 基本概念
    - 任务（Task）: 需要执行的工作单位，可以是函数或代码块。
    - 队列（Queue）: 任务的组织结构，GCD使用队列来调度和管理任务的执行。队列可以是串行的（按顺序执行）或并发的（可以同时执行多个任务）。
    - 并发队列: 多个任务可以同时执行的队列。系统根据可用的 CPU 核心来决定同时运行多少个任务。
    - 串行队列: 任务按照添加顺序一个接一个地执行。
2. 创建队列
    GCD 提供了简单的 API 来创建并管理队列。可以使用 dispatch_queue_create 创建串行或并发队列。
    ```swift
    let serialQueue = DispatchQueue(label: "com.example.serialQueue")
    let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent) // attributes: .concurrent：表示创建一个并行队列
    ```
3. 提交任务
    ```swift
    serialQueue.async { // 串行队列一次只执行一个任务
        print("1. This is executed on a serial queue.")
    }
    serialQueue.async { // 虽然是异步提交，但由于是串行队列，所以两个任务会按顺序一个接一个地执行
        print("2. This is executed on a serial queue.")
    }

    concurrentQueue.async { // 并行队列一次可执行多个任务
        print("1. This is executed on a concurrent queue.")
    }
    concurrentQueue.async { // 任务同时执行，顺序会因任务的执行时间和系统调度的策略而有所不同
        print("2. This is executed on a concurrent queue.")
    }
    ```
4. 全局队列
    GCD 提供了全局队列，可以使用 DispatchQueue.global() 来访问。全局队列是并发的，适用于需要并发执行的任务。
    globalQueue 一般情况下只支持异步（async）方法。
    ```swift
    let globalQueue = DispatchQueue.global()
    globalQueue.async {
        print("This is executed on a global queue.")
    }
    ```
5. 延迟执行
    可以使用 dispatch_after 来实现任务的延迟执行。
    ```swift
    let delayInSeconds = 2.0
    DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
        print("This is executed after a delay.")
    }
    ```
6. 组（Dispatch Groups）
    GCD 支持将多个任务组织在一起，组内的任务可以并行执行。
    可以同步等待所有组内的任务完成，适用于需要等待任务完成再继续执行的场景。
    当所有任务完成后，可以指定一个通知回调，通常用于更新 UI 或处理最终数据。
    - 使用场景：
        - 网络请求：多个网络请求完成后，更新界面显示结果。
        - 文件处理：多个文件处理操作完成后，进行汇总或保存。
    ```swift
    let dispatchGroup = DispatchGroup()

    dispatchGroup.enter() // 表示有一个任务即将开始，每次调用 enter() 都必须对应一个 leave() 调用
    DispatchQueue.global().async { // 将任务异步添加到全局队列中执行
        print("task 1")
        dispatchGroup.leave()
    }
    
    dispatchGroup.enter() // 表示有一个任务即将开始，每次调用 enter() 都必须对应一个 leave() 调用
    DispatchQueue.global().async {
        print("task 2")
        dispatchGroup.leave()
    }

    dispatchGroup.notify(queue: DispatchQueue.main) {
        print("All tasks are completed.")
    }
    ```
7. 信号量（Dispatch Semaphores）
    信号量用于控制对共享资源的访问，可以限制同时执行的任务数量。
    ```swift
    let semaphore = DispatchSemaphore(value: 1)
    let dispatchQueue = DispatchQueue.global()
    
    dispatchQueue.async {
        semaphore.wait()
        print("task 1")
        semaphore.signal()
    }
    dispatchQueue.async {
        semaphore.wait()
        print("task 1")
        semaphore.signal()
    }
    ```
8. 适用场景
    -创建队列：用于管理并行或串行任务。
    - 提交任务：在队列中添加任务，实现异步或同步执行。
    - 全局队列：适用于需要跨应用的后台任务执行。
    - 延迟执行：适用于需要在特定时间后执行的任务。
    - 组（Dispatch Groups）：用于同步多个异步任务，确定所有任务完成后执行后续操作。
    - 信号量（Dispatch Semaphores）：用于控制并发数，确保资源被安全访问。

##### 多个线程之间信息的传递

```swift
// 创建数据共享资源
var sharedResource = 0

// 创建一个并行队列
let resourceQueue = DispatchQueue(label: "com.example.resourceQueue", attributes: .concurrent)

globalQueue.async {
    resourceQueue.async(flags: .barrier) {
        sharedResource += 1
        print("线程 1 修改资源: \(sharedResource)")
    }
}

globalQueue.async {
    resourceQueue.async(flags: .barrier) {
        sharedResource += 1
        print("线程 2 修改资源: \(sharedResource)")
    }
}

globalQueue.async {
    resourceQueue.async {
        print("读取资源: \(sharedResource)")
    }
}
// 代码的输出顺序取决于任务的执行顺序，但最终 sharedResource 的值会是 2
```
