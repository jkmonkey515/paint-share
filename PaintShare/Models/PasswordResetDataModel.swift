//
//  PasswordResetDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/28/21.
//

import SwiftUI

class PasswordResetDataModel: ObservableObject {
    
    @Published var email: String = "" {
        didSet {
            emailMessage = ""
        }
    }
    
    @Published var emailMessage: String = ""
    
    @Published var navigationTag: Int? = nil
    
    func sendResetRequest(dialogsDataModel: DialogsDataModel, mailHasSendDataModel: MailHasSendDataModel) {
        UrlUtils.postRequest(url: UrlConstants.USER_SEND_PASSWORD_RESET_EMAIL, body: PasswordResetBody(email: email, deviceToken: DeviceTokenUtils.deviceToken), dialogsDataModel: dialogsDataModel)
            .then {
                mailHasSendDataModel.maskedEmail = StringUtils.toMaskedEmail(email: self.email)
                self.navigationTag = 1
            }
            .catch {
                error in
                if let validationError = error as? ValidationError {
                    if let emailError = validationError.errors["email"] {
                        self.emailMessage = emailError
                    }
                }
            }
    }
}
