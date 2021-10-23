import Foundation

private
actor Counter {
    private var count: Int = 0
    func increment() -> Int {
        let count = self.count
        Thread.sleep(forTimeInterval: 1.0)
        self.count = count + 1
        return self.count
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
