//
//  RegisterDataModel.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/04/19.
//

import SwiftUI

class RegisterDataModel: ObservableObject {
    
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
    
    @Published var passwordConfirm: String = "" {
        didSet {
            passwordConfirmMessage = ""
        }
    }
    
    @Published var navigationTag: Int? = nil
    
    @Published var checked = false {
        didSet {
            checkedMessage = ""
        }
    }
    
    // validation messages
    
    @Published var emailMessage: String = ""
    
    @Published var passwordMessage: String = ""
    
    @Published var passwordConfirmMessage: String = ""
    
    @Published var checkedMessage: String = ""
    
    func reset() {
        email = ""
        password = ""
        passwordConfirm = ""
        checked = false
    }
    
    func register(dialogsDataModel: DialogsDataModel, mailHasSendDataModel: MailHasSendDataModel) {
//        if !requiredFilled() {
//            return
//        }
        let registerBody = RegisterBody(email: email, password: password, passwordConfirm: passwordConfirm, checked: checked, deviceToken: DeviceTokenUtils.deviceToken)
        UrlUtils.postRequest(url: UrlConstants.USER_NEW, body: registerBody, dialogsDataModel: dialogsDataModel)
            .then {
                DispatchQueue.main.async {
                    mailHasSendDataModel.maskedEmail = StringUtils.toMaskedEmail(email: self.email)
                    self.reset()
                    self.navigationTag = 1
                }
            }
            .catch {
                error in
                DispatchQueue.main.async {
                if let validationError = error as? ValidationError {
                    if let emailError = validationError.errors["email"] {
                        self.emailMessage = emailError
                    }
                    if let passwordError = validationError.errors["password"] {
                        self.passwordMessage = passwordError
                    }
                    if let passwordConfirmError = validationError.errors["passwordConfirm"] {
                        self.passwordConfirmMessage = passwordConfirmError
                    }
                    if let checkedError = validationError.errors["checked"] {
                        self.checkedMessage = checkedError
                    }
                }
                }
            }
    }
}
