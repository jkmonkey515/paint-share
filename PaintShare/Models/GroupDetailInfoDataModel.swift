//
//  GroupDetailInfoDataMode.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/22/21.
//

import SwiftUI

class GroupDetailInfoDataModel: ObservableObject {
    
    var groupId: Int = -1
    
    @Published var groupSearchItem: GroupSearchItem = GroupSearchItem(id: -1, groupDto: GroupDto(id: -1, generatedGroupId: "", groupName: "", groupOwner: UserDto(id: -1, generatedUserId: "", email: "", lastName: "", firstName: "", phone: "", profile: "", updatedAt: UInt64(0),freeUseUntil:UInt64(1)), phone: "", description: "", groupPublic: -1, goodsPublic: -1, updatedAt: UInt64(0), groupApproveStatus: -1, imageUseStatus: -1), rank0Count: 0, rank1Count: 0, rank2Count: 0, statusInGroup: nil, statusInGroupDisplayName: nil, ownedByLoggedinUser: false) {
        didSet {
            self.fullName = groupSearchItem.groupDto.groupOwner.lastName + "　" + groupSearchItem.groupDto.groupOwner.firstName
        }
    }
    
    @Published var reviewDto: ReviewDto? = nil
    
    @Published var fullName: String = ""
    
    @Published var navigationTag: Int? = nil
    
    @Published var showPhoneNumber: Bool = false
    
    func reset() {
        groupId = -1
        groupSearchItem = GroupSearchItem(id: -1, groupDto: GroupDto(id: -1, generatedGroupId: "", groupName: "", groupOwner: UserDto(id: -1, generatedUserId: "", email: "", lastName: "", firstName: "", phone: "", profile: "", updatedAt: UInt64(0),freeUseUntil:UInt64(1)), phone: "", description: "", groupPublic: -1, goodsPublic: -1, updatedAt: UInt64(0), groupApproveStatus: -1, imageUseStatus: -1), rank0Count: 0, rank1Count: 0, rank2Count: 0, statusInGroup: nil, statusInGroupDisplayName: nil, ownedByLoggedinUser: false)
        reviewDto = nil
        fullName = ""
        navigationTag = nil
        showPhoneNumber = false
    }
    
    func getReviewDto(dialogsDataModel: DialogsDataModel) {
        UrlUtils.getRequest(url: UrlConstants.REVIEW_GET_FOR_LOGGED_IN + "?groupId=\(groupSearchItem.groupDto.id)", type: ReviewDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                result in
                self.reviewDto = result
            }
    }
    
    func getGroupSearchDto(dialogsDataModel: DialogsDataModel, mainViewDataModel: MainViewDataModel) {
        UrlUtils.getRequest(url: UrlConstants.GROUP_SEARCH_DTO + "/\(groupId)", type: GroupSearchDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                groupSearchDto in
                if groupSearchDto != nil {
                    self.groupSearchItem = GroupSearchItem(id: groupSearchDto!.id, groupDto: groupSearchDto!.groupDto, rank0Count: groupSearchDto!.rank0Count, rank1Count: groupSearchDto!.rank1Count, rank2Count: groupSearchDto!.rank2Count, statusInGroup: groupSearchDto!.statusInGroup, statusInGroupDisplayName: Constants.getStatusInGroupDisplayName(status: groupSearchDto!.statusInGroup), ownedByLoggedinUser: mainViewDataModel.loggedInUserId == groupSearchDto!.groupDto.groupOwner.id)
                    self.showPhoneNumber = groupSearchDto!.statusInGroup == 1 || groupSearchDto!.statusInGroup == 3 || groupSearchDto!.statusInGroup == 4
                }
                self.getReviewDto(dialogsDataModel: dialogsDataModel)
            }
    }
}
