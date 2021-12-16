import Combine
import Foundation

import class UIKit.UIImage

@MainActor
final class UserViewState: ObservableObject {
    let id: User.ID
    
    @Published private(set) var user: User?
    @Published private(set) var iconImage: UIImage?
    
    init(id: User.ID) {
        self.id = id
    }
    
    func loadUser() async {
        do {
            // User の JSON の取得
            let url: URL = .init(string: "https://koherent.org/fake-service/api/user?id=\(id)")!
            let data = try await downloadData(from: url)
            
            // JSON のデコード
            let user: User = try JSONDecoder().decode(User.self, from: data)
            
            // View への反映
            self.user = user

            // アイコン画像の取得
            let iconData = try await downloadData(from: user.iconURL)
            
            // Data を UIImage に変換
            guard let iconImage: UIImage = .init(data: iconData) else {
                // TODO: エラーハンドリング
                print("Data collapsed.")
                return
            }
            
            // View への反映
            self.iconImage = iconImage
        } catch {
            // TODO: エラーハンドリング
            print(error)
        }
    }
}
