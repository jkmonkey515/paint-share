//
//  AccountManagementDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/27/21.
//

import SwiftUI
import Promises

class AccountManagementDataModel: ObservableObject {
    
    var id: Int = -1
    
    @Published var lastName: String = "" {
        didSet {
            lastNameMessage = ""
        }
    }
    
    @Published var firstName: String = "" {
        didSet {
            firstNameMessage = ""
        }
    }
    
    @Published var phone: String = "" {
        didSet {
            phoneMessage = ""
        }
    }
    
    @Published var profile: String = "" {
        didSet {
            profileMessage = ""
        }
    }
    
    @Published var profileImgKey: String?
    
    @Published var profilePicture: UIImage? = Constants.profileHolderUIImage!
    
    @Published var email: String = "" {
        didSet {
            emailMessage = ""
        }
    }
    
    @Published var password: String = "" {
        didSet {
            passwordMessage = ""
        }
    }
    
    var updatedAt: UInt64 = 0
    
    @Published var userBindtype: Int = -1
    
    // validation messages
    @Published var lastNameMessage: String = ""
    
    @Published var firstNameMessage: String = ""
    
    @Published var phoneMessage: String = ""
    
    @Published var profileMessage: String = ""
    
    @Published var emailMessage: String = ""
    
    @Published var passwordMessage: String = ""
    
    @Published var showLogoutConfirmDialog: Bool = false
    
    @Published var navigationTag: Int? = nil
    
  //  @Published var subscriptionDto: SubscriptionDto?
    
    func reset() {
        id = -1
        firstName = ""
        lastName = ""
        phone = ""
        profile = ""
        profileImgKey = nil
        profilePicture = Constants.profileHolderUIImage!
        email = ""
        password = ""
        updatedAt = 0
        navigationTag = nil
        userBindtype = -1
    }
    
    func getUserInfo(dialogsDataModel: DialogsDataModel) {
        UrlUtils.getRequest(url: UrlConstants.USER_GET_LOGGED_IN_USER, type: UserDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                userDto in
                if userDto != nil {
                    DispatchQueue.main.async {
                        self.reset()
                        self.id = userDto!.id
                        self.firstName = userDto!.firstName
                        self.lastName = userDto!.lastName
                        self.phone = userDto!.phone
                        self.email = userDto!.email
                        self.profile = userDto!.profile ?? ""
                        self.profileImgKey = userDto!.profileImgKey
                        self.updatedAt = userDto!.updatedAt
                        self.loadImg(dialogsDataModel: dialogsDataModel)
                        dialogsDataModel.freeUseUntil=userDto!.freeUseUntil
                        
                        debugPrintLog(message:(DateTimeUtils.timestampToStrFormat(timestamp: userDto!.freeUseUntil)))
                    }
                }
            }
    }
    
    func getUserType(dialogsDataModel:DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.USER_GET_LOGGED_IN_USER, type: UserTypeDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                userTypeDto in
                if userTypeDto != nil {
                    for userBindtype in userTypeDto!.userBind {
                        debugPrintLog(message:"====\(userBindtype.type)====")
                        if userBindtype.type == 2 {
                            self.userBindtype = userBindtype.type
                            return
                        }
                    }
                }
            }
    }
    
    func updateUserInfoUploadImage(dialogsDataModel:DialogsDataModel, isFirstTime: Bool, mainViewDataModel: MainViewDataModel) {
        if self.profilePicture != Constants.profileHolderUIImage! {
            let imageData = self.profilePicture!.jpegData(compressionQuality: 0.6)!
            let request = MultipartFormDataRequest(url: URL(string: UrlConstants.FILE_UPLOAD_IMAGE)!)
            request.addDataField(named: "file", data: imageData, mimeType: "image/jpeg")
            UrlUtils.imgUploadRequest(request: request, dialogsDataModel: dialogsDataModel)
                .then {
                    dataString in
                    DispatchQueue.main.async {
                        self.updateUserInfo(imgKey: dataString, dialogsDataModel: dialogsDataModel, isFirstTime: isFirstTime, mainViewDataModel: mainViewDataModel)
                    }
                }
        } else {
            self.updateUserInfo(imgKey: nil, dialogsDataModel: dialogsDataModel, isFirstTime: isFirstTime, mainViewDataModel: mainViewDataModel)
        }
    }
    
    func updateUserInfo(imgKey: String?, dialogsDataModel: DialogsDataModel, isFirstTime: Bool, mainViewDataModel: MainViewDataModel) {
        let body = UserUpdateBody(lastName: self.lastName, firstName: self.firstName, phone: self.phone, email: self.email, password: self.password, profile: self.profile, profileImgKey: imgKey)
        UrlUtils.postRequest(url: UrlConstants.USER_CHANGE_INFO, body: body, dialogsDataModel: dialogsDataModel)
            .then {
                self.password = ""
                if (isFirstTime) {
                    dialogsDataModel.showFirstTimeSavedDialog = true
                    mainViewDataModel.tabDisabled = false
                } else {
                    dialogsDataModel.showSavedDialog = true
                }
            }
            .catch {
                error in
                if let validationError = error as? ValidationError {
                    if let firstNameError = validationError.errors["firstName"] {
                        self.firstNameMessage = firstNameError
                    }
                    if let lastNameError = validationError.errors["lastName"] {
                        self.lastNameMessage = lastNameError
                    }
                    if let phoneError = validationError.errors["phone"] {
                        self.phoneMessage = phoneError
                    }
                    if let profileError = validationError.errors["profile"] {
                        self.profileMessage = profileError
                    }
                    if let emailError = validationError.errors["email"] {
                        self.emailMessage = emailError
                    }
                    if let passwordError = validationError.errors["password"] {
                        self.passwordMessage = passwordError
                    }
                }
            }
    }
    
    func loadImg(dialogsDataModel: DialogsDataModel) {
        if (self.profileImgKey == nil) {
            return
        }
        UrlUtils.getData(urlString: UrlConstants.IMAGE_S3_ROOT + self.profileImgKey!) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async {
                self.profilePicture = UIImage(data: data)
            }
        }
    }
    
    func logout(dialogsDataModel: DialogsDataModel) {
        UrlUtils.logout()
        dialogsDataModel.loginNavigationTag = nil
    }
    
    func getSubscriptionInformation(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.USER_GET_LOGGED_IN_USER_SUBSCRIPTION, type: SubscriptionDto.self, dialogsDataModel: dialogsDataModel)
            .then{
                subscriptionDto in
                DispatchQueue.main.async {
                    dialogsDataModel.subscriptionDto = subscriptionDto
                    if (subscriptionDto?.status == "active"){
                        debugPrintLog(message:subscriptionDto!.stripeSubscriptionId)
                        debugPrintLog(message:subscriptionDto!.status)
                        debugPrintLog(message:subscriptionDto!.startAt)
                        debugPrintLog(message:subscriptionDto!.endAt)
                        debugPrintLog(message:subscriptionDto!.user.freeUseUntil)
                        debugPrintLog(message:DateTimeUtils.timestampToStrFormat(timestamp: subscriptionDto!.user.freeUseUntil))
                    }else if (subscriptionDto?.status == "suspend"){
                        debugPrintLog(message:subscriptionDto!.stripeSubscriptionId)
                        debugPrintLog(message:subscriptionDto!.status)
                        debugPrintLog(message:subscriptionDto!.startAt)
                        debugPrintLog(message:subscriptionDto!.endAt)
                        debugPrintLog(message:subscriptionDto!.user.freeUseUntil)
                        debugPrintLog(message:DateTimeUtils.timestampToStrFormat(timestamp: subscriptionDto!.user.freeUseUntil))
                    }else{
                        debugPrintLog(message:"no subscription")
                    }
                }
            }
    }
    
    func checkUserDeletable(dialogsDataModel: DialogsDataModel) {
        UrlUtils.getRequest(url: UrlConstants.USER_IS_DELETABLE, type: Bool.self, dialogsDataModel: dialogsDataModel)
            .then {
                isDeletable in
                DispatchQueue.main.async {
                    dialogsDataModel.showDeleteButton = isDeletable ?? false
                }
            }
    }
    
    func deleteAccount(dialogsDataModel: DialogsDataModel) {
        UrlUtils.postRequest(url: UrlConstants.USER_DELETE_ACCOUNT, body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then {
                DispatchQueue.main.async {
                    self.logout(dialogsDataModel: dialogsDataModel)
                }
            }
    }
}
