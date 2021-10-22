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
            }
        }
        .navigationTitle("Swift Zoomin' #8")
    }
}
