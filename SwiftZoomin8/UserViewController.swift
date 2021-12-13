import UIKit

@MainActor
final class UserViewController: UIViewController {
    let id: User.ID
    
    private let iconImageView: UIImageView = .init()
    private let nameLabel: UILabel = .init()
    
    init(id: User.ID) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // レイアウト
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.layer.cornerRadius = 40
        iconImageView.layer.borderWidth = 4
        iconImageView.layer.borderColor = UIColor.systemGray3.cgColor
        iconImageView.clipsToBounds = true
        view.addSubview(iconImageView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 80),
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 16),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // User の JSON の取得
        let url: URL = .init(string: "https://koherent.org/fake-service/api/user?id=\(id)")!
        downloadData(from: url) { [self] result in
            // メインスレッドで実行
            DispatchQueue.main.async {
                do {
                    let data = try result.get()
                    
                    // JSON のデコード
                    let user: User = try JSONDecoder().decode(User.self, from: data)
                    
                    // View への反映
                    title = user.name
                    nameLabel.text = user.name
                    
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
                                iconImageView.image = iconImage
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
