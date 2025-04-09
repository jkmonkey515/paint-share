//
//  LoginDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/8/21.
//

import SwiftUI
import Promises
import LineSDK
import RevenueCat

class LoginDataModel: ObservableObject {
    
    @Published var splashOpacity: Double = 1.0
    
    @Published var loginId: String = "" {
        didSet {
            loginIdMessage = ""
        }
    }
    
    @Published var password: String = "" {
        didSet {
            passwordMessage = ""
        }
    }
    
    @Published var showLoginStatusModal: Bool = false
    
    @Published var showLineLoginFailed: Bool = false

    // validation messages
    
    @Published var loginIdMessage: String = ""
    
    @Published var passwordMessage: String = ""
    
    func checkRequired() -> Bool {
        if loginId.count > 0 && password.count > 0 {
            return true
        } else {
            if loginId.count == 0 {
                loginIdMessage = Constants.REQUIRED_MESSAGE
            }
            if password.count == 0 {
                passwordMessage = Constants.REQUIRED_MESSAGE
            }
            return false
        }
    }
    
    func login(mainViewDataModel: MainViewDataModel, dialogsDataModel: DialogsDataModel, approvalWaitlistDataModel: ApprovalWaitlistDataModel,hamburgerMenuDataModel:HamburgerMenuDataModel) {
        if !checkRequired() {
            return
        }
        let body = LoginBody(email: loginId, password: password)
        self.showLoginStatusModal = true
        UrlUtils.postRequest(url: UrlConstants.LOGIN, body: body, type: LoginResponse.self, dialogsDataModel: dialogsDataModel)
            .then {
                loginResponse in
                let defaults = UserDefaults.standard
                defaults.set(loginResponse!.token, forKey: Constants.LOGGIN_TOKEN_KEY)
                self.loadLoggedInToken(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel, approvalWaitlistDataModel: approvalWaitlistDataModel,hamburgerMenuDataModel:hamburgerMenuDataModel)
            }.catch {
                error in
                if let customError = error as? CustomError {
                    if customError.code == 401 {
                        dialogsDataModel.errorMsg = Constants.WRONG_LOGIN_MESSAGE
                        dialogsDataModel.showErrorDialog = true
                    }
                }
                self.showLoginStatusModal = false
            }
    }
    
    func loadLoggedInToken(mainViewDataModel: MainViewDataModel, dialogsDataModel: DialogsDataModel, approvalWaitlistDataModel: ApprovalWaitlistDataModel,hamburgerMenuDataModel:HamburgerMenuDataModel) {
        UrlUtils.loginToken = nil
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: Constants.LOGGIN_TOKEN_KEY)
        if (token != nil) {
            if (!token!.isEmpty) {
                UrlUtils.loginToken = token!
                DeviceTokenUtils.saveDeviceToken()
                UrlUtils.getRequest(url: UrlConstants.USER_GET_LOGGED_IN_USER, type: UserDto.self, dialogsDataModel: dialogsDataModel)
                    .then {
                        userDto in
                        if (userDto != nil) {
                            let new_app_user_id = String(userDto?.id ?? 0) + userDto!.generatedUserId;
                            print("------------------------------")
                            print(new_app_user_id)
                            RevenueCat.Purchases.shared.logIn(new_app_user_id) { (customerInfo, created, error) in
                                if customerInfo?.entitlements["MonthlySubscription"]?.isActive == true {
                                // Unlock that great "pro" content
                                    print("-----success login again-------")
//                                    mainViewDataModel.checkSubscriptionStatus(dialogsDataModel: dialogsDataModel)
                                    
//                                    dialogsDataModel.showChargeView = false
                                }
                                if let error = error {
                                        // Handle error by displaying a message or performing any other relevant action.
                                        print("-------Login failed with error---------")
                                    } else {
                                        // customerInfo updated for my_app_user_id
                                    }
                                
                            }
                        }
                    }
                UrlUtils.getRequest(url: UrlConstants.USER_GET_LOGGED_IN_USER_INFO_STATUS, type: LoginStatusDto.self, dialogsDataModel: dialogsDataModel)
                    .then {
                        loginStatusDto in
                        if loginStatusDto != nil {
                            DispatchQueue.main.async {
                                mainViewDataModel.loggedInUserId = loginStatusDto!.userId
                                if (loginStatusDto!.status == 2) {
                                   // mainViewDataModel.showAccountNotFinishedDialog = true
                                    mainViewDataModel.selectedTab = 3
                                    mainViewDataModel.tabDisabled = true
                                } else {
                                    mainViewDataModel.selectedTab = 0
                                    /*
                                    if (loginStatusDto!.status == 1) {
                                        dialogsDataModel.mainViewNavigationTag = 1
                                    }
                                     */
                                }
                                mainViewDataModel.getLoggedInUserGroup(dialogsDataModel: dialogsDataModel)
                                approvalWaitlistDataModel.listRequests(dialogsDataModel: dialogsDataModel)
                                
                       //         mainViewDataModel.getLoggedInUserUnreadMessage(dialogsDataModel: dialogsDataModel,hamburgerMenuDataModel:hamburgerMenuDataModel)
                                
//                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
//                                    debugPrintLog(message:"等待结束了")
//                                    if (mainViewDataModel.loggedInUserGroup != nil) {
//                                    hamburgerMenuDataModel.getOwnerUnreadMessage(dialogsDataModel: dialogsDataModel)
//                                    }
//                                                })
//
//                                hamburgerMenuDataModel.getUserUnreadMessage(dialogsDataModel: dialogsDataModel)
                                self.getSubscriptionInformation(dialogsDataModel: dialogsDataModel)
                            }
                        } else {
                            UrlUtils.logout()
                        }
                    }.catch {
                        err in
                        UrlUtils.logout()
                    }.always {
                        self.showLoginStatusModal = false
                        self.splashOpacity = 0
                    }
            } else {
                self.splashOpacity = 0
            }
        } else {
            self.splashOpacity = 0
        }
    }
    
    
    func lineLogin(accesstoken:String,mainViewDataModel: MainViewDataModel, dialogsDataModel: DialogsDataModel, approvalWaitlistDataModel: ApprovalWaitlistDataModel,hamburgerMenuDataModel:HamburgerMenuDataModel) {
        let body = CreateCardBody(token: accesstoken)
        self.showLoginStatusModal = true
        UrlUtils.postRequest(url: UrlConstants.LINE_LOGIN, body: body, type: LoginResponse.self, dialogsDataModel: dialogsDataModel)
            .then {
                loginResponse in
                let defaults = UserDefaults.standard
                defaults.set(loginResponse!.token, forKey: Constants.LOGGIN_TOKEN_KEY)
                self.loadLoggedInToken(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel, approvalWaitlistDataModel: approvalWaitlistDataModel,hamburgerMenuDataModel:hamburgerMenuDataModel)
            }.catch {
                error in
                debugPrintLog(message:error)
                if let customError = error as? CustomError {
                    if customError.code == 401 {
                        dialogsDataModel.errorMsg = Constants.WRONG_LINE_LOGIN_MESSAGE
                        dialogsDataModel.showErrorDialog = true
                    }
                }
                self.showLoginStatusModal = false
            }

        
    }
    
    func appleLogin(appleUserId: String, firstName: String, lastName: String, email: String, mainViewDataModel: MainViewDataModel, dialogsDataModel: DialogsDataModel, approvalWaitlistDataModel: ApprovalWaitlistDataModel,hamburgerMenuDataModel:HamburgerMenuDataModel) {
        let body = AppleLoginBody(appleUserId: appleUserId, firstName: firstName, lastName: lastName, email: email)
        self.showLoginStatusModal = true
        UrlUtils.postRequest(url: UrlConstants.APPLE_LOGIN, body: body, type: LoginResponse.self, dialogsDataModel: dialogsDataModel)
            .then {
                loginResponse in
                let defaults = UserDefaults.standard
                defaults.set(loginResponse!.token, forKey: Constants.LOGGIN_TOKEN_KEY)
                self.loadLoggedInToken(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel, approvalWaitlistDataModel: approvalWaitlistDataModel,hamburgerMenuDataModel:hamburgerMenuDataModel)
            }.catch {
                error in
                debugPrintLog(message:error)
                if let customError = error as? CustomError {
                    if customError.code == 401 {
                        dialogsDataModel.errorMsg = Constants.WRONG_APPLE_LOGIN_MESSAGE
                        dialogsDataModel.showErrorDialog = true
                    }
                }
                self.showLoginStatusModal = false
            }
    }
    
    func getSubscriptionInformation(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.USER_GET_LOGGED_IN_USER_SUBSCRIPTION, type: SubscriptionDto.self, dialogsDataModel: dialogsDataModel)
            .then{
                subscriptionDto in
                DispatchQueue.main.async {
                    dialogsDataModel.subscriptionDto = subscriptionDto
                    dialogsDataModel.getUnreadMessageCounts()
                    AppBadgeNumber.getUnreadMessageCounts()
                    dialogsDataModel.loginNavigationTag = 1
                }
            }
    }
}
