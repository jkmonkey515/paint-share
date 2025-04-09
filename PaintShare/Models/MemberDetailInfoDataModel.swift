//
//  MemberDetailInfoDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/28/21.
//

import SwiftUI

class MemberDetailInfoDataModel: ObservableObject {
    
    @Published var memberListItem: MemberListItem = MemberListItem(id: -1, userDto: UserDto(id: -1, generatedUserId: "", email: "", lastName: "", firstName: "", phone: "", profile: nil, updatedAt: UInt64(0),freeUseUntil:UInt64(1)), statusInGroup: -1, statusInGroupDisplayName: "") {
        didSet {
            self.fullName = memberListItem.userDto.lastName + "　" + memberListItem.userDto.firstName
        }
    }
    
    @Published var fullName: String = ""
    
    func reset() {
        memberListItem = MemberListItem(id: -1, userDto: UserDto(id: -1, generatedUserId: "", email: "", lastName: "", firstName: "", phone: "", profile: nil, updatedAt: UInt64(0),freeUseUntil:UInt64(1)), statusInGroup: -1, statusInGroupDisplayName: "")
        fullName = ""
    }
}
