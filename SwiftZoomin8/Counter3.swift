import Foundation

private
actor Counter {
    private var count: Int = 0
    func increment() -> Int {
        count += 1
        Thread.sleep(forTimeInterval: 1.0)
        return count
    }
}

func counterMain3() {
    let counter: Counter = .init()
    
    Task {
        print(await counter.increment())
    }
    
    Task {
        print(await counter.increment())
    }
}
