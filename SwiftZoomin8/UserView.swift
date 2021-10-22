import SwiftUI

struct UserView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UserViewController {
        UserViewController(id: 1234)
    }
    
    func updateUIViewController(_ viewController: UserViewController, context: Context) {
    }
}
