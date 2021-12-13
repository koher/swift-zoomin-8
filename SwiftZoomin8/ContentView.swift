import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    UserView(id: 1234)
                } label: {
                    Text("User View")
                }
            }
        }
        .navigationTitle("Swift Zoomin' #8")
    }
}
