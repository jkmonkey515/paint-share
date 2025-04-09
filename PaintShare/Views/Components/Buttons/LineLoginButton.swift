//
//  LineLoginButton.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/05/27.
//

//import SwiftUI
//import LineSDK

//struct LineLoginButton: View {
//    var text: String
//
//    var width: CGFloat = 263
//
//    var height: CGFloat = 50
//
//    var disabled: Bool = false
//
//    var onClick: () -> Void = {}
//
//    var body: some View {
//        GeneralButton(onClick: {
//            if (!disabled) {
//                onClick()
//            }
//        }, label: {
//            ZStack {
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(Color(hex: "06C755"))
//                    .frame(width: width, height: height)
//                    .shadow(color: Color(hex: "000000").opacity(0.16), radius: 3, x: 0.0, y: 3)
//                HStack {
//                    Image("line-icon")
//                        .resizable()
//                        .frame(width: 33, height: 33)
//                    Text(text)
//                        .font(.regular18)
//                        .foregroundColor(.white)
//                        .frame(height: 30)
//                }
//            }
//        })
//    }
import LineSDK
import SwiftUI

struct LineLoginButton: UIViewRepresentable {
    let permissions: Set<LoginPermission>

    fileprivate var onLoginSucceed: ((LoginResult) -> Void)?
    fileprivate var onLoginFail: ((LineSDKError) -> Void)?
    fileprivate var onLoginStart: (() -> Void)?

    init(permissions: Set<LoginPermission> = [.profile]) {
        self.permissions = permissions
    }

    // MARK: - Wrapping view

    func makeUIView(context: Context) -> LoginButton {
        let button = LoginButton()
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentHuggingPriority(.required, for: .vertical)
        button.delegate = context.coordinator
        return button
    }

    func updateUIView(_ uiView: LoginButton, context: Context) {}

    // MARK: - Coordinating

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    // MARK: - LoginButton Delegating

    func onLoginSuccess(perform: @escaping (LoginResult) -> Void) -> Self {
        modified(\.onLoginSucceed, with: perform)
    }

    func onLoginFail(perform: @escaping (LineSDKError) -> Void) -> Self {
        modified(\.onLoginFail, with: perform)
    }

    func onLoginStart(perform: @escaping () -> Void) -> Self {
        modified(\.onLoginStart, with: perform)
    }

    private func modified<Value>(_ keyPath: WritableKeyPath<Self, Value>, with value: Value) -> Self {
        var modified = self
        modified[keyPath: keyPath] = value
        return modified
    }
}

extension LineLoginButton {
    class Coordinator: NSObject, LoginButtonDelegate {
        private let parent: LineLoginButton

        init(parent: LineLoginButton) {
            self.parent = parent
        }

        // MARK: - LoginButtonDelegate

        func loginButtonDidStartLogin(_ button: LoginButton) {
            parent.onLoginStart?()
        }

        func loginButton(_ button: LoginButton, didSucceedLogin loginResult: LoginResult) {
            parent.onLoginSucceed?(loginResult)
        }

        func loginButton(_ button: LoginButton, didFailLogin error: LineSDKError) {
            parent.onLoginFail?(error)
        }
    }
}


