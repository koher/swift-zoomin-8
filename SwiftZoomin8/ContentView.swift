import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    UserView()
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
            }
        }
        .navigationTitle("Swift Zoomin' #8")
    }
}
