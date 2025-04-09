//
//  AuthorizationStore.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/08/17.
//

import Combine
import LineSDK

class AuthorizationStore: ObservableObject {
    @Published var isAuthorized = LoginManager.shared.isAuthorized
}
