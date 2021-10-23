import Foundation

private
final class Counter {
    private var count: Int = 0
    func increment() -> Int {
        count += 1
        Thread.sleep(forTimeInterval: 1.0)
        return count
    }
}

func counterMain1() {
    let counter: Counter = .init()
    
    Task {
        print(counter.increment())
    }
    
    Task {
        print(counter.increment())
    }
}
