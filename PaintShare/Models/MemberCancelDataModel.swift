//
//  MemberCancelDataModel.swift
//  PaintShare
//
//  Created by Lee on 2022/5/23.
//

import SwiftUI

class MemberCancelDataModel: ObservableObject {
    
    var searchInProgress: Bool = false
    
    @Published var showRefreshingIcon: Bool = false
    
    @Published var searchPhrase: String = ""
    
    var groupId: Int = -1
    
    @Published var numberOfJoined: Int = 0
    
    @Published var numberOfShared: Int = 0
    
    @Published var numberOfDelete: Int = 0
    
    @Published var memberListItems: [MemberListItem] = []
    
    @Published var page = 0
    
    @Published var showBlock: Bool = false
    
    @Published var showRemove: Bool = false
    
    @Published var navigationTag: Int? = nil
    
    var userIdToBlock: Int?
    
    var userIdToDelete: Int?
    
    func reset() {
        searchInProgress = false
        showRefreshingIcon = false
        searchPhrase = ""
        groupId = -1
        numberOfJoined = 0
        numberOfShared = 0
        memberListItems = []
        page = 0
        navigationTag = nil
        showBlock = false
        showRemove = false
        userIdToBlock = nil
        userIdToDelete = nil
    }
    
    func getMembersCount(dialogsDataModel: DialogsDataModel) {
        UrlUtils.getRequest(url: UrlConstants.USER_GROUP_RELATION_MEMBERS_COUNT + "?groupId=\(self.groupId)", type: MemberCountDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                memberCountDto in
                if (memberCountDto != nil) {
                    self.numberOfJoined = memberCountDto!.totalJoined
                    self.numberOfShared = memberCountDto!.totalShared
                }
            }
    }
    
    func searchFromZeroPage(dialogsDataModel: DialogsDataModel) {
        self.page = 0
        self.search(dialogsDataModel: dialogsDataModel)
    }
    
    func search(dialogsDataModel: DialogsDataModel) {
        if self.searchInProgress {
            if self.page > 0 {
                self.page = self.page - 1
            }
            return
        }
        self.searchInProgress = true
        if (self.page == 0) {
            self.memberListItems = []
        }
        // swiftui list reload bug のため
        let delay: Double = self.page == 0 ? 0.2 : 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let percentEncoded = self.searchPhrase.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            UrlUtils.getRequest(url: UrlConstants.GROUP_ALL_DELETED_MEMBERS, type: [MemberDeleteDto].self, dialogsDataModel: dialogsDataModel)
                .then {
                    memberSearchDtos in
                    if (memberSearchDtos != nil) {
                        if (memberSearchDtos!.count == 0) {
                            if self.page > 0 {
                                self.page = self.page - 1
                            }
                        }
                        memberSearchDtos!.forEach {
                            memberSearchDto in
                            let memberListItem = MemberListItem(id: memberSearchDto.id, userDto: memberSearchDto.userDto, statusInGroup: memberSearchDto.status, statusInGroupDisplayName: memberSearchDto.status == 1 ? "メンバー" : "フレンド")
                            self.memberListItems.append(memberListItem)
                        }
                    } else {
                        if self.page > 0 {
                            self.page = self.page - 1
                        }
                    }
                    self.numberOfDelete = memberSearchDtos!.count
                    self.getMembersCount(dialogsDataModel: dialogsDataModel)
                }
                .always {
                    self.searchInProgress = false
                    self.showRefreshingIcon = false
                }
        }
    }
    
    func block(dialogsDataModel: DialogsDataModel) {
        if (self.userIdToBlock == nil) {
            return
        }
        UrlUtils.postRequest(url: UrlConstants.USER_GROUP_RELATION_BLOCK_USER + "/\(self.userIdToBlock!)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then {
                self.search(dialogsDataModel: dialogsDataModel)
            }
            .always {
                self.userIdToBlock = nil
            }
    }
    
    func unblock(dialogsDataModel: DialogsDataModel) {
        if (self.userIdToBlock == nil) {
            return
        }
        UrlUtils.postRequest(url: UrlConstants.USER_GROUP_RELATION_UNBLOCK_USER + "/\(self.userIdToBlock!)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then {
                self.search(dialogsDataModel: dialogsDataModel)
            }
            .always {
                self.userIdToBlock = nil
            }
    }
    
    func delete(dialogsDataModel: DialogsDataModel) {
        if (self.userIdToDelete == nil) {
            return
        }
        UrlUtils.postRequest(url: UrlConstants.USER_GROUP_RELATION_DELETE_USER_SECONDTIME + "/\(self.userIdToDelete!)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then {
                self.search(dialogsDataModel: dialogsDataModel)
            }
            .always {
                self.userIdToDelete = nil
            }
    }
}
