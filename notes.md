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
