import SwiftUI

struct UserView: View {
    let id: User.ID
    
    @State var user: User?
    @State var iconImage: UIImage?
    
    var body: some View {
        VStack(spacing: 16) { // レイアウト
            Group {
                if let iconImage = self.iconImage {
                    Image(uiImage: iconImage)
                        .resizable()
                } else {
                    Color.clear
                }
            }
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color(uiColor: .systemGray3), lineWidth: 4)
            )

            if let user = self.user {
                Text(user.name)
            }
            
            Spacer()
        }
        .padding(16)
        .onAppear { // user, iconImage の取得
            // User の JSON の取得
            let url: URL = .init(string: "https://koherent.org/fake-service/api/user?id=\(id)")!
            downloadData(from: url) { result in
                // メインスレッドで実行
                DispatchQueue.main.async {
                    do {
                        let data = try result.get()
                        
                        // JSON のデコード
                        let user: User = try JSONDecoder().decode(User.self, from: data)
                        
                        // View への反映
                        self.user = user
                        
                        // アイコン画像の取得
                        downloadData(from: user.iconURL) { iconResult in
                            // メインスレッドで実行
                            DispatchQueue.main.async {
                                do {
                                    let iconData = try iconResult.get()
                                    
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
                                    return
                                }
                            }
                        }
                    } catch {
                        // TODO: エラーハンドリング
                        print(error)
                        return
                    }
                }
            }
        }
    }
}
