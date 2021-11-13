import Combine
import Foundation

import class UIKit.UIImage

final class UserViewState {
    let id: User.ID
    
    @Published private(set) var user: User?
    @Published private(set) var iconImage: UIImage?
    
    init(id: User.ID) {
        self.id = id
    }
}
