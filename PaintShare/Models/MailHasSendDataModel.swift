//
//  MailHasSendDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 6/11/21.
//

import SwiftUI

class MailHasSendDataModel: ObservableObject {
    @Published var maskedEmail: String = "a****bc@g****.com"
    
    func reset() {
        maskedEmail = "a****bc@g****.com"
    }
}
