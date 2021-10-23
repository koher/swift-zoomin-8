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
                Button {
                    counterMain1()
                } label: {
                    Text("Counter (Data Race)")
                }
                Button {
                    counterMain2()
                } label: {
                    Text("Counter (Serial Queue)")
                }
                Button {
                    counterMain3()
                } label: {
                    Text("Counter (Actor)")
                }
                Button {
                    bankAccountMain()
                } label: {
                    Text("Bank Account")
                }
            }
        }
        .navigationTitle("Swift Zoomin' #8")
    }
}
