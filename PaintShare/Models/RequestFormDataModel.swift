//
//  RequestFormDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/26/21.
//

import SwiftUI

class RequestFormDataModel: ObservableObject {
    
    var isFromRelatedSearch: Bool = false
    
    @Published var needNotAppearRefresh: Bool = false
    
    // true: 参加/メンバーリクエスト、false: 在庫共有/フレンドリクエスト
    @Published var isJoin: Bool = true
    
    @Published var groupSearchItem: GroupSearchItem = GroupSearchItem(id: -1, groupDto: GroupDto(id: -1, generatedGroupId: "", groupName: "", groupOwner: UserDto(id: -1, generatedUserId: "", email: "", lastName: "", firstName: "", phone: "", profile: "", updatedAt: UInt64(0),freeUseUntil:UInt64(1)), phone: "", description: "", groupPublic: -1, goodsPublic: -1, updatedAt: UInt64(0), groupApproveStatus: -1, imageUseStatus: -1), rank0Count: 0, rank1Count: 0, rank2Count: 0, statusInGroup: nil, statusInGroupDisplayName: nil, ownedByLoggedinUser: false)
    
    @Published var requestMessage: String = "" {
        didSet {
            requestMessageMessage = ""
        }
    }
    
    @Published var confirmDialogMessage: String = ""
    
    @Published var showConfirmDialog: Bool = false
    
    @Published var showRequestSuccessDialog: Bool = false
    
    // validation messages
    @Published var requestMessageMessage: String = ""
    
    func reset() {
        isFromRelatedSearch = false
        isJoin = true
        groupSearchItem = GroupSearchItem(id: -1, groupDto: GroupDto(id: -1, generatedGroupId: "", groupName: "", groupOwner: UserDto(id: -1, generatedUserId: "", email: "", lastName: "", firstName: "", phone: "", profile: "", updatedAt: UInt64(0),freeUseUntil:UInt64(1)), phone: "", description: "", groupPublic: -1, goodsPublic: -1, updatedAt: UInt64(0), groupApproveStatus: -1, imageUseStatus: -1), rank0Count: 0, rank1Count: 0, rank2Count: 0, statusInGroup: nil, statusInGroupDisplayName: nil, ownedByLoggedinUser: false)
        requestMessage = ""
        confirmDialogMessage = ""
        showConfirmDialog = false
        showRequestSuccessDialog = false
        requestMessageMessage = ""
    }
    
    func showConfirm() {
        if isJoin {
            confirmDialogMessage = "このグループへ\nメンバー申請をしてよろしいですか？"
        } else {
            confirmDialogMessage = "このグループへフレンド申請\nをしてよろしいですか？"
        }
        showConfirmDialog = true
    }
    
    func sendRequest(dialogsDataModel: DialogsDataModel, groupSearchDataModel: GroupSearchDataModel) {
        let body = GroupRequestBody(isJoin: self.isJoin, groupId: self.groupSearchItem.groupDto.id, message: requestMessage)
        UrlUtils.postRequest(url: UrlConstants.USER_GROUP_RELATION_NEW_REQUEST, body: body, dialogsDataModel: dialogsDataModel)
            .then {
                self.showRequestSuccessDialog = true
                groupSearchDataModel.navigationTag = nil
            }
            .catch {
                error in
                if let validationError = error as? ValidationError {
                    if let messageError = validationError.errors["message"] {
                        self.requestMessageMessage = messageError
                    }
                }
            }
    }
}
