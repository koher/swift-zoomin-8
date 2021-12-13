import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    AnyUIViewControllerRepresentable(
                        make: { _ in UserViewController(id: 1234) },
                        update: { _, _ in }
                    )
                } label: {
                    Text("User View")
                }
            }
        }
        .navigationTitle("Swift Zoomin' #8")
    }
}
