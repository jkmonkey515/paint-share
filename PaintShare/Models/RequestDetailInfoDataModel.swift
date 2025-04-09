//
//  RequestDetailInfoDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/26/21.
//

import SwiftUI

class RequestDetailInfoDataModel: ObservableObject {
    
    @Published var waitListItem: WaitListItem = WaitListItem(id: -1,
                                                             userDto: UserDto(id: -1, generatedUserId: "", email: "", lastName: "", firstName: "", phone: "", profile: "", updatedAt: UInt64(0),freeUseUntil:UInt64(1)),
                                                             requestMessage: "",
                                                             statusInGroup: 0,
                                                             statusInGroupDisplayName: "")
    
    func reset() {
        waitListItem = WaitListItem(id: -1,
                                    userDto: UserDto(id: -1, generatedUserId: "", email: "", lastName: "", firstName: "", phone: "", profile: "", updatedAt: UInt64(0),freeUseUntil:UInt64(1)),
                                    requestMessage: "",
                                    statusInGroup: 0,
                                    statusInGroupDisplayName: "")
    }
}
