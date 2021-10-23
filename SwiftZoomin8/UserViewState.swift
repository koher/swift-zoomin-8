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
    
    func loadUser() {
        // User の JSON の取得
        let url: URL = .init(string: "https://koherent.org/fake-service/api/user?id=\(id)")!
        downloadData(from: url) { [self] userData in
            // メインスレッドで実行
            DispatchQueue.main.async {
                do {
                    let data: Data = try userData.get()
                    
                    // JSON のデコード
                    let user: User = try JSONDecoder().decode(User.self, from: data)
                    
                    // プロパティへの反映
                    self.user = user

                    // アイコン画像の取得
                    downloadData(from: user.iconURL) { iconData in
                        // メインスレッドで実行
                        DispatchQueue.main.async {
                            do {
                                let iconData: Data = try iconData.get()
                                
                                // Data を UIImage に変換
                                guard let iconImage: UIImage = .init(data: iconData) else {
                                    // エラーハンドリング
                                    print("The icon image at \(user.iconURL) has an illegal format.")
                                    return
                                }
                                
                                // プロパティへの反映
                                self.iconImage = iconImage
                            } catch {
                                // エラーハンドリング
                                print(error)
                            }
                        }
                    }
                } catch {
                    // エラーハンドリング
                    print(error)
                }
            }
        }
    }
}
