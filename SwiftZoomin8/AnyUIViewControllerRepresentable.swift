import SwiftUI

struct AnyUIViewControllerRepresentable<ViewController: UIViewController>: UIViewControllerRepresentable {
    let make: (Context) -> ViewController
    let update: (ViewController, Context) -> Void
    
    func makeUIViewController(context: Context) -> ViewController {
        make(context)
    }
    
    func updateUIViewController(_ viewController: ViewController, context: Context) {
        update(viewController, context)
    }
}
