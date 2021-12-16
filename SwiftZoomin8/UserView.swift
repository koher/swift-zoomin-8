import SwiftUI

@MainActor
struct UserView: View {
    @StateObject private var state: UserViewState
    
    init(id: User.ID) {
        self._state = .init(wrappedValue: UserViewState(id: id))
    }
    
    var body: some View {
        VStack(spacing: 16) { // レイアウト
            Group {
                if let iconImage = state.iconImage {
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
            
            if let user = state.user {
                Text(user.name)
            }
            
            Spacer()
        }
        .padding(16)
        .task {
            await state.loadUser()
        }
    }
}

extension UIImage: @unchecked Sendable {}
