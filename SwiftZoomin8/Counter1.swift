import Foundation

private
final class Counter {
    private var count: Int = 0
    func increment() -> Int {
        let count = self.count
        Thread.sleep(forTimeInterval: 1.0)
        self.count = count + 1
        return self.count
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
